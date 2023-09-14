with 
    source as (
        select 
            -- Identifier representing unique orders on the platform. PK for the table
            order_id,
            -- identifier representing user who placed the order
            user_id,
            -- iderntifer representing promotion attached to the order
            promo_id,
            -- identifer representing address associated to the order
            address_id,
            -- Date and time when the order was created
            created_at,
            -- Total cost of the order in dollars
            order_cost,
            -- Total cost of shipping the order in dollars
            shipping_cost,
            -- Total cost including shipping in dollars
            order_total,
            -- Identifer representing tracking number of the order
            tracking_id,
            -- Name of the company providing shipping services
            shipping_service,
            -- Estimated date of delivery
            estimated_delivery_at,
            -- Actual date of delivery
            delivered_at,
            -- Status of the order
            status

        from {{ source('postgres', 'orders') }}
    )

select * from source