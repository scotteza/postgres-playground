drop view if exists membership.pending_users ;
drop table if exists membership.users;

drop schema if exists membership;

drop function if exists the_time();

create schema membership;

create table membership.users (
	id serial primary key not null,
	email varchar(255) unique not null,
	first varchar(50),
	last varchar(50),
	created_at timestamptz not null default now(),
	status varchar(10) not null default 'pending'
);

create view membership.pending_users as
select * from membership.users where status = 'pending';

insert into membership.users(email, first, last)
values ('test@test.com', 'Scott', 'Edwards');

select * from membership.pending_users;