select
	first_name,
	count(first_name)
from
	actor
group by
	first_name
order by
	count(first_name) desc