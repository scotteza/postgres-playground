select
	x
from
	generate_series('2001-10-01'::timestamp, '2002-10-01'::timestamp, '9 days') as f(x)