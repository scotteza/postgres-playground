select
	amount,
	payment_date,
	date_part('quarter', payment_date) as quarter,
	date_part('year', payment_date) as year,
	concat('Q', date_part('quarter', payment_date), '-', date_part('year', payment_date)) as quarter_description
from
	payment p
order by
	payment_date