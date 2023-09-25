# Week 1 Project Part 4 Answers

**Question 1 :**  
How many users do we have? 
 -> 130 Unique Users

**Query 1 :**
```sql
SELECT
COUNT(DISTINCT(user_id)) AS users_count
FROM dev_db.dbt_aiyengarpublicstoragecom.users
```
---

**Question 2 :**
On average, how many orders do we receive per hour?
-> 15.041

**Query 2 :**
```sql
SELECT DISTINCT
AVG(COUNT(*)) OVER () AS average_order_per_hour
from dev_db.dbt_aiyengarpublicstoragecom.orders
GROUP BY
EXTRACT(HOUR FROM created_at)
```
---

**Question 3 :**    
On average, how long does an order take from being placed to being delivered?   
-> 3.8913 days  
  
**Query 3 :**  

```sql
SELECT
    AVG(DATEDIFF(DAY, created_at, delivered_at)) AS average_delivery_time_days
FROM
dev_db.dbt_aiyengarpublicstoragecom.orders
WHERE status = 'delivered'
```
---

**Question 4 :**  
How many users have only made one purchase? Two purchases? Three+ purchases?  
-> 1 purchase - 25  
-> 2 purchases - 28  
-> 3+ purchases - 71  
  
**Query 4 :**  
  
```sql
WITH visits AS(
SELECT
COUNT(DISTINCT(order_id)) AS order_count,
CASE
    WHEN order_count = 1 THEN '1 purchase'
    WHEN order_count = 2 THEN '2 purchases'
    WHEN order_count >= 3 THEN '3+ purchases'
END AS purchase_orders

FROM
dev_db.dbt_aiyengarpublicstoragecom.orders
GROUP BY user_id
)

SELECT
purchase_orders,
COUNT(order_count) AS order_count
FROM visits
GROUP BY purchase_orders
```

---

**Question :**    
On average, how many unique sessions do we have per hour?  
-> 39.458 sessions on average per hours    
  
**Query :**  
  
```sql
WITH session_per_hour AS (
SELECT DISTINCT
    EXTRACT(HOUR FROM created_at),
    COUNT(DISTINCT(session_id)) AS average_sessions_per_hour
FROM
    dev_db.dbt_aiyengarpublicstoragecom.events
GROUP BY
    EXTRACT(HOUR FROM created_at)
ORDER BY EXTRACT(HOUR FROM created_at)
)

SELECT 
AVG(average_sessions_per_hour) AS average_sessions_per_hour
FROM session_per_hour
```