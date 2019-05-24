create or replace function random_payments(counter int) returns setof payment
as
$$
	select
		*
	from
		payment p
	where
		p.payment_id in
			(select
				trunc((random() * (32098 - 17503)) + 17503)
			from
				generate_series(1, counter));

	-- select min(payment_id), max(payment_id) from payment;
$$
language sql;

select * from random_payments(42);