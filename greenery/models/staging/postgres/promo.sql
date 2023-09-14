with 
    source as (
        select 
            -- Identifier representing each promotion on the platform
            promo_id,
            -- Dollar amount representing discount provided for each promotion
            discount,
            -- flag determining if the promotion is active or not.
            status

        from {{ source('postgres', 'promos') }}
    )

select * from source