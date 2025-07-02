{{
    config(
        materialize = 'incremental',
        unique_key = 'customer_id',
        on_schema_change = 'append_new_columns',
        incremental_strategy = 'merge'

    )
}}


select
    customer_id,
    customer_name,
    is_married,
    update_at
from airbnb.raw.raw_customer

{% if is_incremental() %}
  WHERE update_at > (select max(update_at) from {{ this }})  
{% endif %}
