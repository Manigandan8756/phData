create or replace TABLE AIRLINES_UNIQUE_ROUTE (
	AIRLINE VARCHAR(16777216),
	AIRLINE_ROUTE VARIANT,
	UNIQUE_ROUTE_COUNT NUMBER(38,0) NOT NULL
);