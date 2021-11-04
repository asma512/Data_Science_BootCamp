--1.	Create a new column called “status” in the rental table (yes, add a permanent column) that uses a case statement to indicate if a film was returned late, early, or on time. 
ALTER TABLE rental 
ADD COLUMN status VARCHAR -- Add "status" col of varchar datatype to the r table

UPDATE rental
SET status = (case -- category 'early','late', 'on time', 'not returned' when respective conditions apply 
when r.return_date is null then 'Not returned' 
when f.rental_duration >  DATE_PART('day',r.return_date -r.rental_date) then 'Early'
when f.rental_duration <  DATE_PART('day',r.return_date-r.rental_date) then 'Late'
Else 'On time' End) -- update all the the categories are in this column
from film f 
inner join inventory i 
	on f.film_id = i.film_id -- joining 'film' to 'inventory' in order to join 'film' and 'rental' as shown in er diagram
inner join rental r 
	on i.inventory_id = r.inventory_id  -- 'film' --> 'rental' as shown in the er diagram

--2.	Show the total payment amounts for people who live in Kansas City or Saint Louis. 
SELECT c1.city, SUM(p.amount) as total_payments -- select city name, use agg sum func on amount for total
FROM payment p     -- join payment->(customer_id)->customer
INNER JOIN customer cust
	ON p.customer_id = cust.customer_id
INNER JOIN address a                     --join customer->(address_id)->address
	ON cust.address_id = a.address_id
INNER JOIN city c1                      -- join address->(city_id)->city
	ON a.city_id = c1.city_id
WHERE c1.city in('Kansas City','Saint Louis') -- only filter out these cities
GROUP BY c1.city; -- group total_payments by city

--3.	How many films are in each category? Why do you think there is a table for category and a table for film category?
SELECT c.name, count(*) as film_count --select category, use agg count func for film_count
FROM film f
INNER JOIN film_category f_c -- join film ->(film_id) -> film_category
	ON f.film_id = f_c.film_id
INNER JOIN category c
	ON f_c.category_id = c.category_id -- join film_category ->(category_id) -> category
group by c.name -- group by category
order by film_count desc; -- sort film count desc

--4.	Show a roster for the staff that includes their email, address, city, and country (not ids)
SELECT CONCAT(s.first_name, ' ', s.last_name) as full_name, s.email, a.address, c1.city, c2.country --select the required col
FROM staff s                 
inner JOIN address a  -- join staff->(address_id)->address
ON s.address_id = a.address_id
inner JOIN city c1    -- join address->(city_id)->city
ON a.city_id = c1.city_id
inner JOIN country c2  -- join city->(country_id)-->country
ON c1.country_id = c2.country_id;

-- 5.	Show the film_id, title, and length for the movies that were returned from May 15 to 31, 2005
SELECT f.film_id, f.title, f.length --select if,title,length
FROM rental r     
INNER JOIN inventory i              -- join rental->(invetory_id)-> inventory
	ON r.inventory_id = i.inventory_id
INNER JOIN film f                   -- join inventory->(film_id)-> film
	ON i.film_id = f.film_id         
WHERE r.return_date BETWEEN '05-15-2005' AND '05-31-2005' -- use between for the given return date range

-- 6.	Write a subquery to show which movies are rented below the average price for all movies. 
SELECT film_id,title, rental_rate --select id,title,rental_rate
FROM film
WHERE rental_rate <  -- filter when rental_rate is less than the avg 
	(SELECT avg(rental_rate) FROM film) -- select the avg of rental_rate for all movies
	
-- 7.	Write a join statement to show which movies are rented below the average price for all movies.
SELECT f1.title,f1.rental_rate --select title,rental_rate
FROM film as f1 -- self join film 
join film as f2
on f1.film_id != f2.film_id -- not equal 
GROUP BY f1.title, f1.rental_rate --group by title, rental_rate to avoid dulipcates
HAVING f1.rental_rate < AVG(f2.rental_rate) --filter where rental rate is less than total average

--8.	Perform an explain plan on 6 and 7, and describe what you’re seeing and important ways they differ.
explain analyze
SELECT film_id,title, rental_rate --select id,title,rental_rate
FROM film
WHERE rental_rate <  -- filter when rental_rate is less than the avg 
	(SELECT avg(rental_rate) FROM film) -- select the avg of rental_rate for all movies
	

explain analyze
SELECT f1.title,f1.rental_rate --select title,rental_rate
FROM film as f1 -- self join film 
join film as f2
on f1.film_id != f2.film_id -- not equal 
GROUP BY f1.title, f1.rental_rate --group by title, rental_rate to avoid dulipcates
HAVING f1.rental_rate < AVG(f2.rental_rate) --filter where rental rate is less than total average

-- The subquery method took less time than the self join. The execution time for subquery is 2.375 ms while self
-- join is 77.320ms. This because there are two filters "  Filter: (f1.rental_rate < avg(f2.rental_rate))" &
--" Join Filter: (f1.film_id <> f2.film_id)".

--9.	With a window function, write a query that shows the film, its duration, and what percentile the duration fits into. This may help https://mode.com/sql-tutorial/sql-window-functions/#rank-and-dense_rank 
SELECT	f.title, 
		f.length as duration, 
		NTILE(100) OVER (ORDER BY f.length) AS percentile --calculate percentile of duration
FROM film f
ORDER BY percentile DESC; --sort percentile by desc order

-- 10.	In under 100 words, explain what the difference is between set-based and procedural programming. Be sure to specify which sql and python are. 
-- SQL is set based as it uses mathematical set theory. It process sets of table data. User tell sql server what you want unlike in procedural progrramming like python
--where the user tells it how to calculate it. Procedural programming uses step by step approach to develop application.

--Bonus:
--Find the relationship that is wrong in the data model. Explain why it’s wrong.
--The relationship between customer and rental is wrong because a customer can have one rental instead of multiple rentals. 

