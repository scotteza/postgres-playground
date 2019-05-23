drop view if exists membership.pending_users ;
drop table if exists membership.users;

drop schema if exists membership;

drop function if exists the_time();

create schema membership;

create or replace function random_string(len int) returns text as
$$
	select substring(md5(random()::text), 0, len) as result
$$
language sql;

create table membership.users (
	id serial primary key not null,
	user_key varchar(18) null default random_string(18 ),
	email varchar(255) unique not null,
	first varchar(50),
	last varchar(50),
	created_at timestamptz not null default now(),
	status varchar(10) not null default 'pending',
	search_field tsvector not null
);

create trigger users_search_update_refresh
before insert or update on membership.users
for each row execute procedure
tsvector_update_trigger(search_field, 'pg_catalog.english', email, first, last);

create view membership.pending_users as 
select * from membership.users where status = 'pending';

insert into membership.users(email, first, last)
values ('test@test.com', 'Scott', 'Edwards');

select * from membership.users
where to_tsvector(concat(email, ' ', first, ' ', last)) @@ to_tsquery('scott & edwards')
and search_field @@ to_tsquery('scott & ! smith')
and search_field @@ to_tsquery('scott & edwa:*');