# Write your MySQL query statement below
with total_amount_per_day as(
    select
    visited_on,
    sum(amount) as total_amount
    from customer
    group by visited_on
),
rolling_sum as(
    select
    visited_on,
    sum(total_amount) over(order by visited_on rows between 6 preceding and current row) as amount,
    avg(total_amount) over(order by visited_on rows between 6 preceding and current row) as average_amount,
    count(*) over(order by visited_on rows between 6 preceding and current row) as no_of_days
    from total_amount_per_day
)
select visited_on,amount,round(average_amount,2)as average_amount from rolling_sum where no_of_days=7 order by visited_on