# Build a medallion architecture in Microsoft Fabric using dbt (Preview)

## Overview
This repository supports the Microsoft Fabric article on building a medallion architecture by using dbt.

It contains the sample data and dbt project used to demonstrate an end-to-end flow from raw data ingestion to curated and reporting-ready outputs in Fabric.

GitHub is used as a convenient sample source. The same architecture can ingest data from any source supported by Copy Job.

## Architecture
GitHub → Copy Job → Lakehouse (Bronze) → dbt (Silver, Gold) → Warehouse

- Copy Job ingests data into Bronze tables  
- dbt transforms data into Silver and Gold models  
- Warehouse stores curated outputs  
- A Fabric pipeline orchestrates the workflow  

## Repository contents
- Sample CSV files (`customers.csv`, `products.csv`, `orders.csv`)  
- dbt project for building Silver and Gold models  

## dbt models

### Silver
- `silver_customers` standardizes country values  
- `silver_products` cleans and converts price data  
- `silver_orders` removes duplicates and standardizes quantity  

### Gold
- `customer_sales_summary` aggregates spend and quantity by customer  
- `product_performance` aggregates units sold by product  
- `daily_sales` aggregates quantity by day  

## Pipeline
Execution sequence: **Copy Jobs → Silver models → Gold models**

## Tutorial
Microsoft Learn article: **[Add tutorial link here]**

> Replace this link after the article is published.
