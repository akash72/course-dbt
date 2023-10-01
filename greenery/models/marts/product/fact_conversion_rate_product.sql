{{
    config(
        materialized = 'table'
    )
}}

select
fot.name,
sum(fot.session_total) as session_total,
sum(fot.order_total) as order_total,
sum(fot.order_total)/ sum(fot.session_total) as daily_conversion_rate_by_product
from {{ ref('fact_order_traffic')}} as fot
group by name