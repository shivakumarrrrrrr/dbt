{{ config(materialized='table') }}
with source_data as (
select *
from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_SHIVA_KUMAR"
),

geo_attributes as (
select _ROW, TIME_ZONE,LATITUDE,LONGITUDE,LOCATION_ISO_CODE,
TOTAL_REGENCIES,
POPULATION,POPULATION_DENSITY,TOTAL_CITIES,TOTAL_DISTRICTS,ISLAND,
PROVINCE,SPECIAL_STATUS,CONTINENT,TOTAL_URBAN_VILLAGES,TOTAL_RURAL_VILLAGES,COUNTRY,
LOCATION_LEVEL,AREA_KM_2_,LOCATION
from source_data
),

covid_case_details as (
select _ROW, TOTAL_RECOVERED,TOTAL_CASES_PER_MILLION,
GROWTH_FACTOR_OF_NEW_DEATHS,TOTAL_ACTIVE_CASES,
NEW_CASES_PER_MILLION,NEW_DEATHS_PER_MILLION,
NEW_RECOVERED,CASE_FATALITY_RATE,NEW_DEATHS,
NEW_CASES,TOTAL_DEATHS,cast(DATE as date) as DATE_,CASE_RECOVERED_RATE,
NEW_ACTIVE_CASES,TOTAL_CASES,TOTAL_DEATHS_PER_MILLION,
GROWTH_FACTOR_OF_NEW_CASES

from source_data
),

monthly_death as (
select  MONTH(DATE_) month_mm,
year(date_) as year_yyyy
        sum(TOTAL_CASES) as tot_monthly_cases
from covid_case_details
group by month_mm,year_yyyy
order by year_yyyy,month_mm 
)



select * from monthly_death
