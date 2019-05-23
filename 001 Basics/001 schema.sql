drop table if exists users;

drop function if exists the_time();

create table users (
	id serial primary key not null,
	email varchar(255) unique not null,
	first varchar(50),
	last varchar(50),
	created_at timestamptz not null default now()
);

insert into users(email, first, last)
values ('test@test.com', 'Scott', 'Edwards');

select * from users;