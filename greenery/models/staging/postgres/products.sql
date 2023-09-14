with 
    source as (
        select 
            -- identifier representing unique product with greenery. PK of the table
            product_id,
            -- Name of the product
            name,
            -- Price of the product 
            price,
            -- Quantity of each product available with greenery inventory
            inventory

        from {{ source('postgres', 'products') }}
    )

select * from source