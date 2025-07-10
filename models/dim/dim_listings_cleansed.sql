{{
    config(
        materialized = "table"
    )
}}


with all_src_listings as (
    select 
        *
    from {{ ref('src_listings') }}
),
clean_listings as (
    select
    listing_id,
    listing_name,
    listing_url,
    host_id,
    room_type,
        CASE
            WHEN minimum_nights = 0 THEN 1
            ELSE minimum_nights
        END AS minimum_nights,


        REPLACE(
            price_str,
            '$') :: NUMBER(
            10,
            2
        ) AS price,
        created_at,
        updated_at
    FROM all_src_listings
)

select 
    listing_id,
    listing_name,
    listing_url,
    room_type,
    host_id,
    minimum_nights,
    price,
    created_at,
    updated_at,
from clean_listings



