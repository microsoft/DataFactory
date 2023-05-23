# Data Engineering: Use T-SQL to create VIEW

You can work with the data in the lakehouse in two modes:

1. Lake mode enables you to add and interact with tables, files, and folders in the Lakehouse.
2. **SQL Endpoint enables you to use SQL to query the tables in the lakehouse and manage its relational data model. It allows you to run Transact-SQL statements to query, filter, aggregate, and otherwise explore data in lakehouse tables.**

Fabric's data warehouse experience allows you to transition from the lake view of the Lakehouse (which supports data engineering and Apache Spark) to the SQL experiences that a traditional data warehouse would provide.

In the data warehouse experience, you'll model data using **tables and views**, **run T-SQL to query data across the data warehouse and Lakehouse**, use **T-SQL to perform DML operations on data inside the data warehouse**, and **serve reporting layers like Power BI**.

<mark>Now, please follow along with the instructor as they demonstrate the steps shown in the GIF.
</mark>

![Use T-SQL to create VIEW](media/sql_view.gif?raw=true)
The GIF above is based on the lakehouse named lab140lakehouse and the table named nyc_taxi, and presents the steps:
1. Navigate to your Workspace.
2. Access your lakehouse by clicking on the lakehouse name.
3. Switch from the lakehouse mode to SQL Endpoint (located in the top right corner).
3. Click on "New SQL Query".
4. Enter the following query into the SQL editor: `SELECT * FROM nyc_taxi_with_discounts`
5. Execute the query by clicking the "Run" button.
6. Confirm the results.
7. Compose a new query to create a view: `CREATE VIEW vNycTaxi AS SELECT * FROM NYC_Taxi`
8. Execute this query.
9. Once the query has completed, expand the "Views" section and click on "Refresh". 
10. After expanding "Views", confirm the presence of the new view. Now, you can query this view.