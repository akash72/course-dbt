{{
    config(
        materialized = 'view'
    )
}}

With session_orders as (
    select 
    session_id,
    count(distinct order_id) as order_total
    from {{ ref('events')}}
    where order_id is not null
    group by session_id
)

select
pe.date,
pe.name,
pe.product_id,
pe.page_url,
count(distinct pe.session_id) as session_total,
count(pe.session_id) as page_view_total,
count(distinct pe.user_id) as user_total,
sum(so.order_total) as order_total 
from {{ ref('int_product_events')}} as pe
left join session_orders as so on pe.session_id = so.session_id
group by 
pe.date,
pe.page_url,
pe.product_id,
pe.name