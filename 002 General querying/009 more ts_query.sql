select distinct
	title,
	year,
	sum(amount) over (partition by title,year):: money
from
	raw_sales
where
	search_field @@ to_tsquery('moon:*');