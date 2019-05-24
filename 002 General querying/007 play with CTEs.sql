with
sales_rollup as
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
		title),
q1_2007 as 
	(select * from sales_rollup where qyear = 'Q1-2007'),
q2_2007 as 
	(select * from sales_rollup where qyear = 'Q2-2007')

select sum(percent_of_total_quarterly_sales) from q1_2007
union all
select sum(percent_of_total_quarterly_sales) from q2_2007
