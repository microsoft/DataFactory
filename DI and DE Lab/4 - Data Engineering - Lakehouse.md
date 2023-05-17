# Data Engineering: Lakehouse artifact overview

A Lakehouse presents as a database and is built on top of a data lake using Delta Lake files and tables. Lakehouses combine the SQL-based analytical capabilities of a relational data warehouse and the flexibility and scalability of a data lake. Lakehouses store all data formats and can be used with various analytics tools and programming languages. As cloud-based solutions, lakehouses can scale automatically and provide high availability and disaster recovery.

Some benefits of a lakehouse include:
- Lakehouses use Spark and SQL engines to process large-scale data and support machine learning or predictive modeling analytics.
- Lakehouse data is organized in a schema-on-read format, which means you define the schema as needed rather than having a predefined schema.
- Lakehouses support ACID (Atomicity, Consistency, Isolation, Durability) transactions through Delta Lake formatted tables for data consistency and integrity.
- Lakehouses are a single location for data engineers, data scientists, and data analysts to access and use data.

A Lakehouse is a great option if you want a scalable analytics solution that maintains data consistency. 


<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>


![Lakehouse artifact overview](media/2_30frames.gif?raw=true)

## Get data from the lakehouse


The most common way to work with data in delta tables in Spark is to use Spark SQL. You can embed SQL statements in other languages (such as PySpark or Scala) by using the spark.sql library.

<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>

![Get data from the lakehouse](media/3.gif?raw=true)

There are three ways to access Lakehouse data in your notebook:

* Using a relative path to the default Lakehouse, as shown in the code example.
* Using the full ABFS (Azure Blob File System) path.
* Using the syntax "/lakehousename/path", which is only valid when accessing a Lakehouse within the same workspace.

`df = spark.sql("SELECT * FROM lab140lakehouse.nyc_taxi LIMIT 1000")` - This line of code uses the spark.sql() function to run an SQL query on a table called nyc_taxi located in the lakehouse lab140lakehouse. The query selects all columns (*) from the table and limits the result to the first 1000 rows with the LIMIT 1000 clause. The result of the query is then stored in a PySpark DataFrame called df.

`display(df)` - the display() function is used to visualize the contents of a DataFrame in a tabular format. In this case, it visualizes the contents of the df DataFrame created in the previous line.

```pyspark
df = spark.sql("SELECT * FROM lab140lakehouse.nyc_taxi LIMIT 1000")

display(df)
```

Alternatively, you can use the %%sql magic in a notebook to run SQL statements.

```sql
%%sql
SELECT * FROM lab140lakehouse.nyc_taxi LIMIT 1000
```

The code `df.select("vendorID", "tripDistance", "fareAmount", "tipAmount").show(5)` is used to display the first five rows of a DataFrame called df, and only the columns named: "vendorID", "tripDistance", "fareAmount", "tipAmount". This is a useful function when working with large datasets to quickly inspect the data and ensure that it has been loaded correctly.

```pyspark
df.select("vendorID", "tripDistance", "fareAmount", "tipAmount").show(5)
```

When working with data, one of the initial tasks is to read it into the environment for analysis. Once the data is loaded, basic analysis such as filtering, sorting, and aggregating can be performed. However, as the scale and complexity of the data increase, there is a need for more advanced data engineering scenarios such as data cleansing, transformation, and aggregation. 

## Data aggregation, summarization and correlation

In this scenario, the data engineer could aggregate and summarize the data to provide insights into the overall trends and patterns in the dataset. For example, they could group the data by some columns (such as VendorID or RatecodeID) and calculate some summary statistics for the numerical columns (such as average fare_amount or total trip_distance). This could involve using Spark's built-in aggregation functions (such as groupBy and agg) to perform these calculations.

The code calculates the average fare amount per month by grouping the DataFrame df by year and month of the lpep_pickup_datetime column. It uses the avg function from the [pyspark.sql.functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html) module to calculate the average fare amount and aliases the resulting column as "average_fare". The resulting DataFrame average_fare_per_month is sorted by year and month and is displayed using the display function. Finally, the code saves the results to a new delta table named "average_fare_per_month" using the write function with "delta" format, and "overwrite" mode.

```pyspark
from pyspark.sql.functions import col, year, month, dayofmonth, avg

df = spark.read.table("nyc_taxi")

# Calculate average fare amount per month
average_fare_per_month = (
    df
    .groupBy(year("lpepPickupDatetime").alias("year"), month("lpepPickupDatetime").alias("month"))
    .agg(avg("fareAmount").alias("average_fare"))
    .orderBy("year", "month")
)
display(average_fare_per_month)

# Save the results to a new delta table
average_fare_per_month.write.format("delta").mode("overwrite").saveAsTable("average_fare_per_month")
```

### Refresh Lakehouse explorer

<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>

![Refresh Lakehouse explorer](media/new_table_refresh.gif?raw=true)


### Scatter chart

This code snippet demonstrates how to create a scatter plot using Matplotlib in Python. The code assumes that the Spark DataFrame df contains the columns fare_amount and trip_distance. First, the Spark DataFrame is converted to a Pandas DataFrame using the toPandas() function. Then, a scatter plot is created using ax.scatter() function. The x and y arguments of the scatter() function represent the variables to be plotted on the x- and y-axes, respectively. The alpha argument controls the transparency of the points in the scatter plot. The axis labels and title are set using the ax.set_xlabel(), ax.set_ylabel(), and ax.set_title() functions. Finally, the plot is displayed using the plt.show() function. This code can be used to visualize the correlation between fare amount and trip distance in the DataFrame.


```pyspark
import matplotlib.pyplot as plt

# convert Spark DataFrame to Pandas DataFrame
df_pd = df.select(['fareAmount', 'tripDistance']).toPandas()

# create scatter plot
fig, ax = plt.subplots()
ax.scatter(x=df_pd['tripDistance'], y=df_pd['fareAmount'], alpha=0.5)

# set axis labels and title
ax.set_xlabel('Trip Distance')
ax.set_ylabel('Fare Amount')
ax.set_title('Correlation between Fare Amount and Trip Distance')

# show the plot
plt.show()

```