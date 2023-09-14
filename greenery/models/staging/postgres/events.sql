with 
    source as (
        select 
            -- Identifier representing unique event on the greenery platform. PK of the table
            event_id,
            -- Identifier representing every unique session on the website
            session_id,
            -- Identifier representing user associated to the event and sessions
            user_id,
            -- page url associated to the event
            page_url,
            -- date and time when the event was created 
            created_at,
            -- Type of event
            event_type,
            -- order associated to the event
            order_id,
            -- products associated to the event and the order
            product_id

        from {{ source('postgres', 'events') }}
    )

select * from source