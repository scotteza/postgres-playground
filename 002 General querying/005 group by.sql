/*
with actor_rollup as (select first_name, count(first_name) as name_count from actor group by first_name)

select * from actor_rollup order by name_count desc
*/

with actor_rollup as
	(select
		a.actor_id,
		a.first_name,
		a.last_name,
		count(1) over(partition by a.first_name) as first_name_count,
		count(1) over(partition by a.last_name) as last_name_count,
		count(1) over(partition by a.first_name, last_name) as full_name_count
	from
		actor a)
select distinct
	ar.*
from
	actor_rollup ar
order by
	ar.full_name_count desc,
	ar.first_name,
	ar.last_name