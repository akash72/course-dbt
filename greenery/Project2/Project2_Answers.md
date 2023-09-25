# Week 2 Project Part 1 Answers

**Question 1 :**  
What is our user repeat rate?
 -> 79.84% of the users are repeat customers

```sql
 WITH orders_cnt AS (
    SELECT user_id
    , COUNT(order_id) AS order_total
    FROM dev_db.dbt_aiyengarpublicstoragecom.orders
    GROUP BY 1
), 
users_rep AS (
SELECT COUNT(DISTINCT IFF(order_total>=2,user_id, NULL)) AS repeat_users
    , COUNT(DISTINCT user_id) AS user_count
FROM orders_cnt
)
SELECT ROUND(DIV0(repeat_users,user_count)*100,2) AS repeat_percentage
, *
FROM users_rep
```

**Question 2 :**  
What are good indicators of a user who will likely purchase again?

- Large number of Visits on the Website.
- More time spent on the website with other web metrics like click rate, session time and geolocation
- Large number of orders placed 
- Low return or cancellations done by the user
- High spend
- Product availablity 

What about indicators of users who are likely NOT to purchase again?

- Competitive rate for products
- High returns and cancellation
- Low time spent on the website


**Question 3:**

```sql
SELECT * FROM dev_db.dbt_aiyengarpublicstoragecom.inventory_snapshot where dbt_valid_to is not null
```