select
	f.film_id,
	f.title,
	group_concat(a.first_name || ' ' || a.last_name) as actors,
	to_tsvector(concat(f.title, group_concat(a.first_name || ' ' || a.last_name))) as search_field
from
	film f
	inner join film_actor fa
		on f.film_id = fa.film_id
	inner join actor a
		on a.actor_id = fa.actor_id
group by
	f.film_id,
	f.title