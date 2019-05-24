with
q1_2007 as
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
	where
		quarter = 1
		and year = 2007
	order by
		title),
q2_2007 as
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
	where
		quarter = 2
		and year = 2007
	order by
		title)

select
	(select trunc(sum(percent_of_total_quarterly_sales)) from q1_2007) as q1,
	(select trunc(sum(percent_of_total_quarterly_sales)) from q2_2007) as q2