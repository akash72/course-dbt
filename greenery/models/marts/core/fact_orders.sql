{{
  config(
    materialized='table'
  )
}}

with orders as (
    select * from {{ ref('orders')}}
),

order_items as (
    select * from {{ref ('order_items')}}
),

order_detail as (
    select
        order_id
        , count (distinct product_id) as product_per_order
        , sum (quantity) as total_quantity
    from order_items
    group by 1
),


address as (
    select * from {{ ref('address')}}
),

fact_orders as (
    select 
        ord.order_id,
        ord.user_id,
        ord.promo_id,
        ord.address_id,
        ad.state,
        ad.country,
        date(ord.created_at) as order_date,
        ord.order_cost,
        ord.shipping_cost,
        ord.order_total,
        ord.tracking_id,
        ord.shipping_service,
        ord.estimated_delivery_at,
        date(ord.delivered_at) as delivery_date,
        ord.status,
        od.product_per_order,
        od.total_quantity
    from orders ord
    left join order_detail od
        on ord.order_id = od.order_id
    left join address ad
        on ord.address_id = ad.address_id
)

select * from fact_orders