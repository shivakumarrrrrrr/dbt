

select MONTH(DATE_) as month_int,
monthname(DATE_) as for_month,
sum(TOTAL_CASES) as tot_monthly_cases
from {{ ref('ans_model.covid_case_details') }}
group by for_month, month_int
order by month_int 