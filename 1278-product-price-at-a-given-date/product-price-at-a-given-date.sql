# Write your MySQL query statement below
with old_price as(
    select distinct(product_id) as product_id,
    10 as old_price
    from products
), 
product_new_price as(
select product_id,new_price as price from products where (product_id,change_date) in 
(select
product_id,MAX(change_date
)
from products where change_date <= '2019-08-16'
group by product_id
))
select
o.product_id,
case
 when p.price is null then o.old_price 
 else p.price
end as price
from old_price o left join product_new_price p on o.product_id=p.product_id
