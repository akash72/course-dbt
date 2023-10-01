{{
    config(
        materialized ='table'
    )
}}

select 
    date(ev.created_at) as date,
    pr.name as name,
    ev.product_id,
    ev.page_url,
    ev.session_id,
    ev.user_id
from {{ ref('events')}} ev
left join {{ref('products')}} pr on pr.product_id = ev.product_id
where event_type = 'page_view' and ev.product_id is not null