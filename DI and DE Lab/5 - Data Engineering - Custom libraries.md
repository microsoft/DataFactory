# Data Engineering: Custom libraries & advanced visualisation

Libraries provide reusable code that Data Engineers may want to include in their Spark application. Each workspace comes with a pre-installed set of libraries available in the Spark run-time and available to be used immediately in the notebook or Spark job definition. Based on the user scenarios and specific needs, you can include other libraries. There are two types of libraries you may want to include:
- Feed library: Feed libraries are the ones that come from public sources or repositories. You can install Python feed libraries from PyPI and Conda by specifying the source in the Library Management portals. You can also use a Conda environment specification .yml file to install libraries.
- Custom library: Custom libraries are the code built by you or your organization. .whl, .jar and .tar.gz can be managed through Library Management portals. Note that .tar.gz is only supported for R language, please use .whl for Python custom libraries.


## Install library

The code line `pip install altair` is used to install the Python package "Altair" via the package manager "pip". Altair is a library for creating interactive visualizations in Python.

"Pip" is a package manager for Python that allows users to easily install, manage, and update Python packages (libraries) from the Python Package Index (PyPI) and other package repositories. Pip can be used to install packages globally on the system or locally in a specific virtual environment.

```pyspark
pip install altair
```

## Create custom visualisation with a new library

First, the code imports the Altair library using the alias "alt". Next, the code uses Spark SQL to select all columns from the "NYC_Taxi" table in the "Bronze" database, limiting the result to the first 5000 rows. The resulting DataFrame is then converted to a Pandas DataFrame using the toPandas method.

The alt.Chart method is then called with the Pandas DataFrame as the data source, and the mark_point method is used to specify that the chart should use points as the visual mark. The encode method is then used to specify the encoding for the x-axis, y-axis, and color of the points, as well as the tooltip values. The x-axis is mapped to the "tripDistance" column, the y-axis is mapped to the "fareAmount" column, and the color of the points is mapped to the "paymentType" column, which is treated as a categorical variable. The tooltip displays the "tripDistance", "fareAmount", and "paymentType" columns for each point.

Finally, the interactive method is called to enable interactivity in the resulting visualization, allowing the user to zoom, pan, and view tooltip information when hovering over points in the scatter plot.

```pyspark
import altair as alt

df = spark.sql("SELECT * FROM Bronze.NYC_Taxi LIMIT 5000")

data = df.toPandas()

alt.Chart(data).mark_point().encode(
    x='tripDistance',
    y='fareAmount',
    color='paymentType:N',
    tooltip=['tripDistance', 'fareAmount', 'paymentType']
).interactive()
```
