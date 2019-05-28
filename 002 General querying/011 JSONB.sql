drop table if exists film_docs;

create table if not exists film_docs(data jsonb);

insert into film_docs(data)
select row_to_json(film)::jsonb from film;

select
	(data ->> 'title') as Title,
	(data -> 'length') as Length
from
	film_docs;