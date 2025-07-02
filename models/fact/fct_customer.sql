{{
    config(
        materialize = 'incremental',
        unique_key = 'customer_id',
        incremental_strategy = 'merge'

    )
}}


select
    customer_id,
    customer_name,
    update_at
from airbnb.raw.raw_customer

{% if is_incremental() %}
  WHERE update_at > (select max(update_at) from {{ this }})  
{% endif %}
