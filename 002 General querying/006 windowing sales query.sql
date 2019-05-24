create or replace view raw_sales as
select
	f.title,
	f.description,
	f.length,
	f.rating,
	p.amount,
	p.payment_date,
	date_part('quarter', p.payment_date) as quarter,
	date_part('month', p.payment_date) as month,
	date_part('year', p.payment_date) as year,
	concat('Q', date_part('quarter', p.payment_date)::text, '-', date_part('year', p.payment_date)::text) as qyear,
	cash_words(amount::money) as spelling_it_out,
	to_tsvector(concat(title, description)) as search_field
from
	film f
	inner join inventory i on i.film_id = f.film_id
	inner join rental r on r.inventory_id = i.inventory_id
	inner join payment p on p.rental_id = r.rental_id;

with sales_rollup as
	(select distinct
		title,
		quarter,
		year,
		qyear,
		sum(amount) over (partition by title, qyear) as quarterly_sales,
		sum(amount) over (partition by qyear) as total_quarterly_sales,
		sum(amount) over (partition by title, qyear) / sum(amount) over (partition by qyear) * 100 as percent_of_total_quarterly_sales
	from
		raw_sales
	order by
		title)
select
	qyear,
	trunc(sum(sr.percent_of_total_quarterly_sales))
from
	sales_rollup sr
group by
	qyear