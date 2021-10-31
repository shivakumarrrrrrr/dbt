{{ config(materialized='table') }}
with source_data as (
select *
from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_SHIVA_KUMAR"
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
year(date_) as year_yyyy,
        sum(TOTAL_CASES) as tot_monthly_cases
from covid_case_details
group by month_mm,year_yyyy
order by year_yyyy,month_mm 
),


mom_growth as (select a.month_mm,a.year_yyyy, 
(a.tot_monthly_cases - b.tot_monthly_cases) as diff_cases
from monthly_death as a
left join (select * from monthly_death ) as b on
concat(b.month_mm+1,b.year_yyyy) = concat(a.month_mm,a.year_yyyy)
order by a.year_yyyy,a.month_mm )


select * from mom_growth




