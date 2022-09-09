use sakila;
# 1.Write a query to display for each store its store ID, city, and country.
select * from sakila.city;
select * from sakila.country;
select * from sakila.store;
select * from address;

SELECT s.store_id, c.city, co.country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country co ON (c.country_id=co.country_id);


# 2.Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM sakila.store;		
SELECT * FROM sakila.staff;		
SELECT * FROM sakila.payment;	

SELECT s.store_id, round(sum(p.amount),2) as amount
FROM sakila.store s
JOIN sakila.staff f USING(store_id)
JOIN sakila.payment p USING(staff_id)
GROUP BY s.store_id;

  
#3.What is the average running time of films by category?
select * from category;
select * from film;
select * from film_category;

select c.name as category, round(avg(f.length),2) as the_average_time
from film as f join film_category using (film_id) join category as c using (category_id)
group by c.name
order by avg(length) desc;

# 4.Which film categories are longest?
select c.name as category, round(avg(f.length),2) as the_average_time
from film as f join film_category using (film_id) join category as c using (category_id)
group by c.name
order by avg(length) desc limit 1;

# 5.Display the most frequently rented movies in descending order.
SELECT * FROM sakila.film;		
SELECT * FROM sakila.inventory;	
SELECT * FROM sakila.rental; 	

SELECT f.title AS title_of_films, COUNT(rental_id) AS frequently_rented
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
GROUP BY f.title
ORDER BY COUNT(rental_id) DESC;	

    
# 6.List the top five genres in gross revenue in descending order.
-- category, film_category, inventory, payment, and rental.)
SELECT * FROM sakila.category;			
SELECT * FROM sakila.film_category;		
SELECT * FROM sakila.inventory;			
SELECT * FROM sakila.rental;			
SELECT * FROM sakila.payment;			

SELECT c.name AS category, round(SUM(amount),2) AS gross_revenue
FROM sakila.category c 
JOIN sakila.film_category fc USING(category_id)
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING(inventory_id)
JOIN sakila.payment p USING(customer_id)
GROUP BY c.name
ORDER BY round(SUM(amount)) DESC
LIMIT 5; 							


# 7.Is "Academy Dinosaur" available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory join store using (store_id) join film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;