{{
    config(materialize = "table",
    )
}}


select 
    *, 
    NVL(
        host_name,
        'Anonymous'
    ) AS host_name_cleaned,
 
from {{ ref('src_host') }}