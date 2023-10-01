{{
    config(
        materialized = 'table'
    )
}}

select
fot.date,
sum(fot.session_total) as session_total,
sum(fot.order_total) as order_total,
sum(fot.order_total)/ sum(fot.session_total) as daily_conversion_rate
from {{ ref('fact_order_traffic')}} as fot
group by date