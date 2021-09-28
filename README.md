# phData Northwoods Airlines POV

**Overview**
<br>

Proof of value for the Northwoods airlines, to analyse the provided 
airlines, airports and flights dataset to gather business insights 
against their competition.

**Technology Used**
<br>
- PySpark
- Databricks
- Snowflake

**Provided Business Insights for POV**
<br>

- Total number of flights by airline and airport on a monthly basis
- On-time percentage of each airline for the year 2015
- Airlines with largest number of delays
- Cancellation reasons by airport
- Delay reasons by airport
- Airline with most unique routes

**Data Extraction**

Data has been extracted from the Databricks File System, since all
the files are loaded into the DBFS as per the requirement.

- airlines.csv
- airports.csv
- flights.csv

**Data Ingestion**

A final cleaned dataset is pushed into the Snowflake database
and views has been created on top of it for each business requirement.

- RAW_DATA      : Contains the raw files
- CURATED_DATA  : Contains a cleaned file

**Assumptions**

- Removed records which are having ORIGIN_AIRPORT, 
  DESTINATION_AIRPORT, AIRLINE as NULL.