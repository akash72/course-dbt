{{
  config(
    materialized='table'
  )
}}

WITH user_events AS (
  SELECT *
  FROM {{ref('int_user_events')}}
), 
user_purchase AS (
  SELECT session_id
    , product_id
    , CAST(MAX(IFF(event_type = 'add_to_cart' AND created_at < last_checkout_time_utc , 1, 0)) AS BOOLEAN) AS purchase_flag
  FROM user_events
  WHERE product_id IS NOT NULL
  GROUP BY all
), 
Event_with_purchase AS (
  SELECT e.*
    , f.purchase_flag
  FROM user_events e
  INNER JOIN user_purchase f ON e.session_id = f.session_id
  AND e.product_id = f.product_id
)
SELECT create_date,
country,
state,
user_id,
SUM(duration) AS total_time,
COUNT(DISTINCT session_id) AS total_sessions,
product_id,
name,
MAX(purchase_flag) AS purchase_flag,
COUNT(DISTINCT IFF(event_type = 'page_view', event_id, NULL)) AS page_views,
COUNT(DISTINCT IFF(event_type = 'add_to_cart', event_id, NULL)) AS add_to_cart,
COUNT(DISTINCT IFF(event_type = 'page_view', session_id, NULL)) AS page_views_session,
COUNT(DISTINCT IFF(event_type = 'add_to_cart', session_id, NULL)) AS add_to_cart_session
FROM Event_with_purchase e
GROUP BY all