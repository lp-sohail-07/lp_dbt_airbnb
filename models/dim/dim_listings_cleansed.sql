
with all_src_listings as (
    select 
        *
    from {{ ref('src_listings') }}
),
clean_listings as (
    select 
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
    count(1) 
from {{ ref('src_host') }}
where host_name is null



