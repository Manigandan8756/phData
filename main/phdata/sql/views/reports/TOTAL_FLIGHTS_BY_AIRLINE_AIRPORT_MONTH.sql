drop view if exists USER_MANI.CURATED_DATA.TOTAL_FLIGHTS_PER_MONTH_BASIS;
create view if not exists USER_MANI.CURATED_DATA.TOTAL_FLIGHTS_PER_MONTH_BASIS as (
with
destination as (select * from (select DESTINATION_AIRPORT as Airport, YEAR, MONTH, AIRLINE,
count(*) OVER (PARTITION BY DESTINATION_AIRPORT, YEAR, MONTH, AIRLINE) as Out_Flights,
row_number() OVER (PARTITION BY DESTINATION_AIRPORT, YEAR, MONTH, AIRLINE ORDER BY DESTINATION_AIRPORT ASC) as row_no
from "USER_MANI"."CURATED_DATA"."FLIGHTS") as dest where dest.row_no = 1),

origin as (select * from (select ORIGIN_AIRPORT as Airport, YEAR, MONTH, AIRLINE,
count(*) OVER (PARTITION BY ORIGIN_AIRPORT, YEAR, MONTH, AIRLINE) as In_Flights,
row_number() OVER (PARTITION BY ORIGIN_AIRPORT, YEAR, MONTH, AIRLINE ORDER BY ORIGIN_AIRPORT ASC) as row_no
from "USER_MANI"."CURATED_DATA"."FLIGHTS") as orig where orig.row_no = 1)

select origin.Airport, origin.YEAR, origin.MONTH, origin.AIRLINE, (destination.Out_Flights+origin.In_Flights) as Total_Flights
from origin, destination
where origin.Airport = destination.Airport and origin.YEAR = destination.YEAR and origin.MONTH = destination.MONTH
and origin.AIRLINE = destination.AIRLINE
order by origin.Airport, origin.YEAR, origin.MONTH, origin.AIRLINE, (origin.In_Flights + destination.Out_Flights)
);