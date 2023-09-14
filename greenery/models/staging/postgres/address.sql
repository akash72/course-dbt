with 
    source as (
        select 
            -- identifier representing unique address for each customers. PK for the table
            address_id,
            -- The Address line for each customer address
            address,
            -- The zipcode of the address
            zipcode,
            -- State where address is based in
            state,
            -- Country where address is based in
            country

        from {{ source('postgres', 'addresses') }}
    )

select * from source