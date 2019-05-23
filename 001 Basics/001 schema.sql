drop table if exists users;

create or replace function the_time() returns timestamptz as
$$
	select now() as result;
$$ language sql;

create table users (
	id serial primary key not null,
	email varchar(255) unique not null,
	first varchar(50),
	last varchar(50),
	created_at timestamptz not null default the_time()
);

insert into users(email, first, last)
values ('test@test.com', 'Scott', 'Edwards');

select * from users;