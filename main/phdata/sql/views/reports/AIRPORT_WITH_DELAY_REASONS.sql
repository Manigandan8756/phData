DROP VIEW IF EXISTS USER_MANI.CURATED_DATA.DELAY_REASONS_BY_AIRPORT;
CREATE VIEW IF NOT EXISTS USER_MANI.CURATED_DATA.DELAY_REASONS_BY_AIRPORT as (
WITH
destination as (SELECT DESTINATION_AIRPORT AS AIRPORT,
SUM(CASE WHEN AIR_SYSTEM_DELAY != 0 THEN 1 ELSE 0 END) AS AIR_SYSTEM_DELAY,
SUM(CASE WHEN SECURITY_DELAY != 0 THEN 1 ELSE 0 END) AS SECURITY_DELAY,
SUM(CASE WHEN AIRLINE_DELAY != 0 THEN 1 ELSE 0 END) AS AIRLINE_DELAY,
SUM(CASE WHEN LATE_AIRCRAFT_DELAY != 0 THEN 1 ELSE 0 END) AS LATE_AIRCRAFT_DELAY,
SUM(CASE WHEN WEATHER_DELAY != 0 THEN 1 ELSE 0 END) AS WEATHER_DELAY
FROM "USER_MANI"."CURATED_DATA"."FLIGHTS"
GROUP BY DESTINATION_AIRPORT),

origin as (SELECT ORIGIN_AIRPORT AS AIRPORT,
SUM(CASE WHEN AIR_SYSTEM_DELAY != 0 THEN 1 ELSE 0 END) AS AIR_SYSTEM_DELAY,
SUM(CASE WHEN SECURITY_DELAY != 0 THEN 1 ELSE 0 END) AS SECURITY_DELAY,
SUM(CASE WHEN AIRLINE_DELAY != 0 THEN 1 ELSE 0 END) AS AIRLINE_DELAY,
SUM(CASE WHEN LATE_AIRCRAFT_DELAY != 0 THEN 1 ELSE 0 END) AS LATE_AIRCRAFT_DELAY,
SUM(CASE WHEN WEATHER_DELAY != 0 THEN 1 ELSE 0 END) AS WEATHER_DELAY
FROM "USER_MANI"."CURATED_DATA"."FLIGHTS"
GROUP BY ORIGIN_AIRPORT)

select origin.AIRPORT, (destination.AIR_SYSTEM_DELAY+origin.AIR_SYSTEM_DELAY) as Total_AIR_SYSTEM_DELAY
, (destination.SECURITY_DELAY+origin.SECURITY_DELAY) as Total_SECURITY_DELAY
, (destination.AIRLINE_DELAY+origin.AIRLINE_DELAY) as Total_AIRLINE_DELAY
, (destination.LATE_AIRCRAFT_DELAY+origin.LATE_AIRCRAFT_DELAY) as Total_LATE_AIRCRAFT_DELAY
, (destination.WEATHER_DELAY+origin.WEATHER_DELAY) as Total_WEATHER_DELAY
from origin, destination
where origin.AIRPORT = destination.AIRPORT
order by origin.AIRPORT
);