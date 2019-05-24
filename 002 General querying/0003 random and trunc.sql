select
	t.random_number
from
	(select
		trunc(random() * 1000 + 1) as random_number
	from
		generate_series(1, 1000)
	) t
order by
	t.random_number desc