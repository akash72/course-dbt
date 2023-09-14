with 
    source as (
        select 
            -- Identifier represeting Unique user within greenery platform. PK for the table
            user_id,
            -- first name of the user
            first_name,
            -- last name of the user
            last_name,
            -- email address of the user
            email,
            -- phone number of the user
            phone_number,
            -- date and time when the user profile was created
            created_at,
            -- date and time when user profile was updated
            updated_at,
            -- Foregin key used to create association between user and address table
            address_id

        from {{ source('postgres', 'users') }}
    )

select * from source