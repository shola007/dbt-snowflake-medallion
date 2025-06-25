
select
    customer_id,
    customer_name,
    country,
    count(*) as total_orders,
    sum(amount) as total_sales
from
 {{ref('cleaned_customers')}}
 group by 
    customer_id, customer_name, country
 order by 
    total_sales desc