# Data Engineering: Shortcuts and final table 

Shortcuts in a lakehouse allow users to reference data without copying it. It unifies data from different lakehouses, workspaces, or external storage, such as ADLS Gen2 or AWS S3. You can quickly make large amounts of data available in your lakehouse locally without the latency of copying data from the source.

## Create shortcut to external ADLS Gen2

To create a shortcut, open Lakehouse Explorer and select where to place the shortcut under Tables or Files. Creating a shortcut to Delta formatted table under Tables in Lakehouse Explorer will automatically register it as a table, enabling data access through Spark, SQL endpoint, and default dataset. Spark can access shortcuts in Files for data science projects or for transformation into structured data.

**In this final exercise, we aim to merge two datasets: the NYC_Taxi structured delta table that currently resides in our lakehouse, and an external CSV dataset located in ADLS Gen 2 that contains information about discounts offered on specific days. The final table will reflect all records from the NYC_Taxi dataset with an additional column from the discount dataset, allowing us to see the total discount value per vendor for a given day. This will enable us to gain insights into how vendors offer discounts and how it impacts their revenue.**

<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>

![Create shortcut to external ADLS Gen2](media/shortcut.gif?raw=true)

The GIF above is based on the lakehouse named lab140lakehouse and the table named nyc_taxi, and presents the steps:
1. Navigate to your workspace by clicking on the workspace icon (located on the left sidebar).
2. Select your lakehouse ("Bronze") and open it by clicking "Open lakehouse" on the right sidebar (the GIF presents the lineage view).
3. Expand the context menu on the Files section inside your lakehouse.
4. Select "New Shortcut"
5. Select creation of a new shortcut for Azure Data Lake Storage Gen2.
6. Proceed to fill out the connection settings.
    - URL: `https://buildlab140ekot.dfs.core.windows.net/`
    - Connection: Create new connection
    - Connection name: NewConnectionToADLS
    - Authentication kind: Shared Access Signature (SAS)
    - SAS token: `?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwlacupx&se=2023-06-01T10:49:05Z&st=2023-05-04T02:49:05Z&spr=https,http&sig=0e0%2BlbFhxx3lcyz79VF272PLEzd0UdyMD348iNvBvQQ%3D`
7. Click "Next".
8. Proceed to fill out the Shortcut settings:
    - Shortcut Name: `SideLoadingDiscountData`
    - Target Location URL: confirm it's `https://buildlab140ekot.dfs.core.windows.net/`
    - Target Location  Sub Path `/data`
9. Confirm that a new icon named "SideLoadingDiscountData" appears under the "Files" section, and inside that folder there is a CSV file Generated-NYC-Taxi-Green-Discounts.csv.
10. Return to the notebook and verify that under the Files section, there is "SideLoadingDiscountData" folder, and inside the folder there is a CSV file Generated-NYC-Taxi-Green-Discounts.csv.

**If you encounter the error message "The specified connection name already exists. Try choosing a different name", please make sure that the name you choose for the connection is unique.**

## Load new data

If you've adhered to all the naming conventions, you'll be able to execute the cell code that reads the CSV data into a new dataframe:

```pyspark
df = spark.read.format("csv").option("header","true").load("Files/SideLoadingDiscountData/Generated-NYC-Taxi-Green-Discounts.csv")

# df now is a Spark DataFrame containing CSV data from "Files/SideLoadingDiscountData/Generated-NYC-Taxi-Green-Discounts.csv".

display(df)
```

## Unpivot sideloaded data

The import pandas as pd line imports the Pandas library and assigns it an alias pd.

Melt the discounts DataFrame: The pd.melt() function is used to convert the discouts_df PySpark DataFrame to a long format by converting date columns into rows. First, discouts_df.toPandas() is used to convert the PySpark DataFrame to a Pandas DataFrame. Then, pd.melt() takes the Pandas DataFrame, uses 'VendorID' as the identifier variable (id_vars), sets the 'date' as the variable name (var_name), and 'discount' as the value name (value_name). The melted DataFrame is stored in discouts_pd_df.

Convert the melted DataFrame to a PySpark DataFrame: The spark.createDataFrame() function is used to convert the melted Pandas DataFrame discouts_pd_df back to a PySpark DataFrame, which is stored in the discounts_spark_df variable.


```pyspark
import pandas as pd

# Melt discouts_df to long format
discouts_pd_df = pd.melt(df.toPandas(), id_vars=['VendorID'], var_name='date', value_name='discount')

discounts_spark_df = spark.createDataFrame(discouts_pd_df)

display(discounts_spark_df)

```

## Prepare data for join

```pyspark
from pyspark.sql.functions import to_date

nyc_taxi_df = spark.sql("SELECT * FROM Bronze.NYC_Taxi")

nyc_taxi_df = nyc_taxi_df.withColumn("date", to_date("lpepPickupDatetime"))

display(nyc_taxi_df)

```

## Join two datasets and save results 

```pyspark
from pyspark.sql.functions import col

# Create aliases for your DataFrames
df1_alias = nyc_taxi_df.alias("df1")
df2_alias = discounts_spark_df.alias("df2")

# Define the join condition using the aliases
join_condition = [col("df1.vendorID") == col("df2.VendorID"), col("df1.date") == col("df2.date")]

# Perform the join using the aliases
result_df = df1_alias.join(df2_alias, join_condition, how='inner')  # You can use other join types like 'left', 'right', 'outer', etc.

# Select only the desired columns
result_df = result_df.select("df1.vendorID", "df1.lpepPickupDatetime", "df2.discount")

display(result_df)

# Save the results to a new delta table
result_df.write.format("delta").mode("overwrite").saveAsTable("nyc_taxi_with_discounts")

```

## Refresh Lakehouse explorer  

<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>

![Refresh Lakehouse explorer](media/results.gif?raw=true)
The GIF above is based on the lakehouse named lab140lakehouse and the table named nyc_taxi, and presents the steps:
1. Expand the advanced context menu for the "Tables" section within the Lakehouse explorer.
2. Click on "Refresh".
3. Cofirm the presence of a new table named "nyc_taxi_with_discounts".