with 
    source as (
        select 
            -- Identifer representing unique orders
            order_id,
            -- Products associated to each order
            product_id,
            -- quantity for each product ordered
            quantity

        from {{ source('postgres', 'order_items') }}
    )

select * from source