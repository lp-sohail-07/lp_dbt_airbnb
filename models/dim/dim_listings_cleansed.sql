{{
    config(
        materialized = "view"
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
        ) AS price
    FROM all_src_listings
)

select 
        listing_id,
    listing_name,
    listing_url,
    room_type,
    minimum_nights,
    price 
from {{ ref('src_host') }}




