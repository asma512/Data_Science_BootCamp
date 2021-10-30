--1.Show all customers whose last names start with T. Order them by first name from A-Z.

select * from customer      -- selects all the columns in customers
where last_name like 'T%'   -- filters the last name starts with 'T' using 'like' operator and % wildcard
order by first_name;        -- the result-set will have first name sorted in asc order

--2.Show all rentals returned from 5/28/2005 to 6/1/2005

select * from rental where return_date   -- selects all the columns in rental
between '2005-05-28' and '2005/06/01';   -- using 'between' operator to select the return dates in the given range

--3.How would you determine which movies are rented the most?

select f.title,count(r.rental_id) as rent_count 
from film f 									-- selects film title &  use count agg function for rent_count
inner join inventory i 							-- joining 'film' to 'inventory' on film_id
	on f.film_id = i.film_id 
inner join rental r 							-- joining 'inventory' to 'rental' on inventory_id
	on i.inventory_id = r.inventory_id  
												-- 'film' --> 'rental' (ER diagram)
group by f.film_id 								-- group rent_count by film_id
order by 2 desc;  								-- sort the rent_count in desc order

-- 4.	Show how much each customer spent on movies (for all time) . Order them from least to most.

select cust.customer_id, concat(cust.first_name,' ',cust.last_name) as full_name, -- select cust id, full name using concat, 
sum(pay.amount) as total_spend -- agg func sum on 'amount' as 'total_spend'
from payment pay 
inner join customer cust 
	on pay.customer_id=cust.customer_id  
-- join 'customer' to 'payment' to get 'amount' from 'payment' as shown in er diagram
group by cust.customer_id --group total_spend by cust id
order by 3; --sort the total spend in asc order

--5.	Which actor was in the most movies in 2006 (based on this dataset)? 
--Be sure to alias the actor name and count as a more descriptive name. Order the results from most to least.

select act.actor_id, concat(act.first_name,' ',act.last_name) as full_name, count(f.film_id) as movie_count
-- select actor id, full name using concat, number of movies using count agg func
from actor act 
inner join film_actor f_a 
	on act.actor_id= f_a.actor_id
inner join film f 
	on f.film_id = f_a.film_id 
-- joining 'actor' to 'film_actor' to get film_id which will link 'actor' to 'film' as shown in er diagram
where f.release_year=2006 --filter the given year
group by act.actor_id -- group movie_count by actor id
order by 3 desc;   --and sort movie_count in desc order

--6.Write an explain plan for 4 and 5. Show the queries and explain what is happening in each one. 
-- Problem 4 explain plan:

/*"Sort  (cost=424.62..426.11 rows=599 width=68) (actual time=22.341..22.463 rows=599 loops=1)"
"  Sort Key: (sum(pay.amount))"
"  Sort Method: quicksort  Memory: 71kB"
"  ->  HashAggregate  (cost=388.00..396.98 rows=599 width=68) (actual time=21.017..22.063 rows=599 loops=1)"
"        Group Key: cust.customer_id"
"        Batches: 1  Memory Usage: 553kB"
"        ->  Hash Join  (cost=22.48..315.02 rows=14596 width=23) (actual time=1.189..14.730 rows=14596 loops=1)"
"              Hash Cond: (pay.customer_id = cust.customer_id)"
"              ->  Seq Scan on payment pay  (cost=0.00..253.96 rows=14596 width=8) (actual time=0.009..3.097 rows=14596 loops=1)"
"              ->  Hash  (cost=14.99..14.99 rows=599 width=17) (actual time=1.165..1.168 rows=599 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 38kB"
"                    ->  Seq Scan on customer cust  (cost=0.00..14.99 rows=599 width=17) (actual time=0.009..0.992 rows=599 loops=1)"
"Planning Time: 0.326 ms"
"Execution Time: 23.288 ms"
It performs on the agg (sum(pay.amount)) followed by hash join and cond. The execution time is 23.288ms.
*/

Explain Analyze
select cust.customer_id, concat(cust.first_name,' ',cust.last_name) as full_name, -- select cust id, full name using concat, 
sum(pay.amount) as total_spend -- agg func sum on 'amount' as 'total_spend'
from payment pay 
inner join customer cust 
	on pay.customer_id=cust.customer_id  
-- join 'customer' to 'payment' to get 'amount' from 'payment' as shown in er diagram
group by cust.customer_id --group total_spend by cust id
order by 3; --sort the total spend in asc order

-- Problem 5 explain plan:
/*
"Sort  (cost=236.61..237.11 rows=200 width=44) (actual time=13.785..13.827 rows=200 loops=1)"
"  Sort Key: (count(f.film_id)) DESC"
"  Sort Method: quicksort  Memory: 40kB"
"  ->  HashAggregate  (cost=226.46..228.96 rows=200 width=44) (actual time=13.668..13.738 rows=200 loops=1)"
"        Group Key: act.actor_id"
"        Batches: 1  Memory Usage: 64kB"
"        ->  Hash Join  (cost=85.50..199.15 rows=5462 width=21) (actual time=0.518..12.173 rows=5462 loops=1)"
"              Hash Cond: (f_a.film_id = f.film_id)"
"              ->  Hash Join  (cost=6.50..105.76 rows=5462 width=19) (actual time=0.091..10.019 rows=5462 loops=1)"
"                    Hash Cond: (f_a.actor_id = act.actor_id)"
"                    ->  Seq Scan on film_actor f_a  (cost=0.00..84.62 rows=5462 width=4) (actual time=0.008..2.889 rows=5462 loops=1)"
"                    ->  Hash  (cost=4.00..4.00 rows=200 width=17) (actual time=0.070..0.071 rows=200 loops=1)"
"                          Buckets: 1024  Batches: 1  Memory Usage: 18kB"
"                          ->  Seq Scan on actor act  (cost=0.00..4.00 rows=200 width=17) (actual time=0.008..0.033 rows=200 loops=1)"
"              ->  Hash  (cost=66.50..66.50 rows=1000 width=4) (actual time=0.417..0.418 rows=1000 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 44kB"
"                    ->  Seq Scan on film f  (cost=0.00..66.50 rows=1000 width=4) (actual time=0.005..0.276 rows=1000 loops=1)"
"                          Filter: ((release_year)::integer = 2006)"
"Planning Time: 3.526 ms"
"Execution Time: 13.919 ms"
It performs on the agg (count(film_id)) followed by hash joins and conds. The execution time is 13.919 ms.
*/
Explain Analyze
select act.actor_id, concat(act.first_name,' ',act.last_name) as full_name, count(f.film_id) as movie_count
-- select actor id, full name using concat, number of movies using count agg func
from actor act 
inner join film_actor f_a 
	on act.actor_id= f_a.actor_id
inner join film f 
	on f.film_id = f_a.film_id 
-- joining 'actor' to 'film_actor' to get film_id which will link 'actor' to 'film' as shown in er diagram
where f.release_year=2006 --filter the given year
group by act.actor_id -- group movie_count by actor id
order by 3 desc;   --and sort movie_count in desc order


--7.    What is the average rental rate per genre?

select cat.name,avg(f.rental_rate) as avg_rent_rate from film f --select name, the avg rental rate using avg agg func
inner join film_category f_c 
	on f.film_id = f_c.film_id -- joining 'flim' with 'film_category' which will link 'film' to 'category'
inner join category cat 
	on cat.category_id = f_c.category_id -- 'film' --> 'category' as shown in the er diagram
group by cat.category_id --group avg rental_rate by category_id
order by 2 desc --sort the avg in desc order

--8.	How many films were returned late? Early? On time?
select case -- category 'early','late', 'on time', 'not returned' when respective conditions apply 
when r.return_date is null then 'Not returned' 
when f.rental_duration >  DATE_PART('day',r.return_date -r.rental_date) then 'Early'
when f.rental_duration <  DATE_PART('day',r.return_date-r.rental_date) then 'Late'
Else 'On time' 
End as return_status, -- all the the categories are in this column
count (f.film_id) as film_count -- # of movies using count agg func
from film f 
inner join inventory i 
	on f.film_id = i.film_id -- joining 'film' to 'inventory' in order to join 'film' and 'rental' as shown in er diagram
inner join rental r 
	on i.inventory_id = r.inventory_id  -- 'film' --> 'rental' as shown in the er diagram
group by return_status -- group # of movies by return_staus
order by film_count desc; -- sort the flim_count by desc order


--9.	What categories are the most rented and what are their total sales?
SELECT cat.name, COUNT(cust.customer_id) as rent_count , --select category name, rent_count with count agg func, 
--total_sales with sum agg func on amount
SUM(pay.amount) as total_sales
FROM Category cat 
inner join Film_category f_c 
	on cat.category_id=f_c.category_id  -- join category->(category_id)->film_category
inner join  film f
	on f_c.film_id=f.film_id            -- join film_category->(film_id)->film
inner join inventory i 
	on f.film_id=i.film_id			    -- join film->(film_id)->inventory
inner join  rental r
	on i.inventory_id=r.inventory_id	-- join inventory->(invetory_id)->rent
inner join customer cust
	on r.customer_id=cust.customer_id	-- join rent-> (customer_id)->customer
inner join  payment pay
	on r.rental_id=pay.rental_id        -- join rent -> (rental_id)--> payment

GROUP BY cat.category_id   --group the total_sales by category_id   
ORDER BY 2 desc; --sort rent_count in desc order

--10.	Create a view for 8 and a view for 9. Be sure to name them appropriately. 

Create view rental_return_status
as select case -- category 'early','late', 'on time', 'not returned' when respective conditions apply 
when r.return_date is null then 'Not returned' 
when f.rental_duration >  DATE_PART('day',r.return_date -r.rental_date) then 'Early'
when f.rental_duration <  DATE_PART('day',r.return_date-r.rental_date) then 'Late'
Else 'On time' 
End as return_status, -- all the the categories are in this column
count (f.film_id) as film_count -- # of movies using count agg func
from film f 
inner join inventory i 
	on f.film_id = i.film_id -- joining 'film' to 'inventory' in order to join 'film' and 'rental' as shown in er diagram
inner join rental r 
	on i.inventory_id = r.inventory_id  -- 'film' --> 'rental' as shown in the er diagram
group by return_status -- group # of movies by return_staus
order by film_count desc; -- sort the flim_count by desc order

Create view top_rental_sales as
SELECT cat.name, COUNT(cust.customer_id) as rent_count , --select category name, rent_count with count agg func, 
--total_sales with sum agg func on amount
SUM(pay.amount) as total_sales
FROM Category cat 
inner join Film_category f_c 
	on cat.category_id=f_c.category_id  -- join category->(category_id)->film_category
inner join  film f
	on f_c.film_id=f.film_id            -- join film_category->(film_id)->film
inner join inventory i 
	on f.film_id=i.film_id			    -- join film->(film_id)->inventory
inner join  rental r
	on i.inventory_id=r.inventory_id	-- join inventory->(invetory_id)->rent
inner join customer cust
	on r.customer_id=cust.customer_id	-- join rent-> (customer_id)->customer
inner join  payment pay
	on r.rental_id=pay.rental_id        -- join rent -> (rental_id)--> payment

GROUP BY cat.category_id   --group the total_sales by category_id   
ORDER BY 2 desc; --sort rent_count in desc order

-- Bonus:
--Write a query that shows how many films were rented each month. Group them by category and month.


select cat.name,Date_part('month',r.rental_date), count(r.rental_id) 
from rental r -- join rental-> inventory -> film -> film_category-category to get category id, name and rental id,date
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on f.film_id=i.film_id 
inner join film_category f_c 
	on f_c.film_id = f.film_id
inner join category cat 
	on cat.category_id = f_c.category_id
group by cat.category_id,Date_part('month',r.rental_date) -- group by category and month
order by 2; --sort month in asc


