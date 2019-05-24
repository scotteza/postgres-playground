with actor_rollup as (select first_name, count(first_name) as name_count from actor group by first_name)

select * from actor_rollup order by name_count desc