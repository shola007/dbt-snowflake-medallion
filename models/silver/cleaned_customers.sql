{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

with ranked_customers as (
    select *,
           row_number() over (
               partition by customer_id
               order by updated_at desc
           ) as row_num
    from {{ source('raw_data', 'customers') }}
)

select *
from ranked_customers
where row_num = 1
{% if is_incremental() %}
  and updated_at > (select max(updated_at) from {{ this }})
{% endif %}
