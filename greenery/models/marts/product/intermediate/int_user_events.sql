{{
  config(
    materialized='table'
  )
}}

with
events as (
    select * from {{ ref('events')}}
),
products as (
    select * from {{ ref('products')}}
),
user as (
   select * from {{ ref('users')}}
),
user_address as (
 select * from {{ ref('address')}}
),
user_attribute as (
 SELECT user_id,
created_at,
first_name,
last_name,
email,
phone_number,
address,
zipcode,
state,
country
FROM user us
LEFT JOIN user_address ad ON us.address_id = ad.address_id
),
user_session as (
 select session_id,
 MIN(created_at) AS starttime_utc,
 MAX(created_at) AS endtime_utc,
 MAX(IFF(event_type = 'checkout', created_at, NULL)) AS last_checkout_time_utc
 FROM events
 GROUP bY 1
)
SELECT DATE(ev.created_at) AS create_date,
ev.created_at,
ev.event_id,
ev.session_id,
us.starttime_utc AS session_start_time,
TIMESTAMPDIFF('minute', us.starttime_utc, us.endtime_utc) AS duration,
us.last_checkout_time_utc,
ev.order_id,
ev.event_type,
ev.user_id,
ua.state,
ua.country,
p.product_id,
p.name
FROM events ev
LEFT JOIN products p ON ev.product_id = p.product_id
LEFT JOIN user_attribute ua ON ev.user_id = ua.user_id
LEFT JOIN user_session us ON ev.session_id = us.session_id