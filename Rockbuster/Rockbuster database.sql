/* Rockbuster Sleath LLC
Key Questions:
Where does the revenue come from?
What is the average rental rate, rental duration and replacement cost?
Who are the top countries with the highest revenue?  What is their average amount they pay?
What are the top movie genre? Does movie genre varies from country to country?
What is the highest rental rate of movies watched? Does rental rate affect the total count of product sold?*/


/* Minimum - Average - Maximum */

select
	min(rental_rate) as min_rental_rate,
	avg(rental_rate) as avg_rental_rate,
	max(rental_rate) as max_rental_rate
from film;


select
	min(rental_duration) as min_rental_duration,
	avg(rental_duration) as avg_rental_duration,
	max(rental_duration) as max_rental_duration
from film;


select
	min(replacement_cost) as min_replacement_cost,
	avg(replacement_cost) as avg_replacement_cost,
	max(replacement_cost) as max_replacement_cost
from film;


/* Top customers with highest revenue */

select
	country,
	count(cu.customer_id) as total_customers,
	sum(pa.amount) as total_revenue
	
from payment pa inner join rental rn
on pa.rental_id = rn.rental_id inner join customer cu
on rn.customer_id = cu.customer_id inner join address ad
on cu.address_id = ad.address_id inner join city ct
on ad.city_id = ct.city_id inner join country co
on ct.country_id = co.country_id

group by country 
order by total_revenue desc


/* Top film with highest revenue */

select 
	ca.name as film_genre,
	sum(pa.amount) as total_revenue
	
from category ca inner join film_category fc
on ca.category_id = fc.category_id inner join film fi
on fc.film_id = fi.film_id inner join inventory iv
on fi.film_id = iv.film_id inner join rental rn
on rn.rental_id = pa.rental_id

group by film_genre
order by total_revenue desc


/* Top movie genres with highest customer */

select 
	ca.name,
	count(cu.customer_id) as total_genre

from category ca inner join film_category fc
on ca.category_id = fc.category_id inner join inventory iv
on fc.film_id = iv.film_id inner join rental rn
on iv.inventory_id = rn.inventory_id inner join customer cu
on rn.customer_id = cu.customer_id

group by ca.name
order by total_genre desc


/* Top countries with their top genre with highest revenue */

select 
	country,
	ca.name as film_genre,
	count(ca.name) as count_genre
	
from category ca inner join film_category fc
on ca.category_id = fc.category_id inner join film fi
on fc.film_id = fi.film_id inner join inventory iv
on iv.inventory_id = rn.inventory_id inner join customer cu
on rn.customer_id = cu.customer_id inner join address ad
on cu.address_id = ad.adress_id inner join city ct
on ad.city_id = ct.city_id inner join country co
on ct.country_id = co.country_id

group by country, film_genre
order by country_genre desc


/* Top rental_rate being purchase by the customers */

select
	fi.rental_rate as rentals,
	count(cu.customer_id) as customer_count
	
from category ca inner join film_category fc
on ca.category_id = fc.category_id inner join film fi
on fc.film_id = fi.film_id inner join inventory iv
on fi.film_id = iv.film_id inner join rental rn
on iv.inventory_id = rn.inventory_id inner join customer cu
on rn.customer_id = cu.customer_id inner join address ad
on cu.address_id = ad.address_id inner join city ct
on ad.city_id = ct.city_id inner join country co
on ct.country_id = co.country_id

group by fi.rental_rate
order by customer_count desc


/* Top rental_rate by the top countries or customers */

select
	country,
	rental_rate,
	count(rental_rate) as total_rental_rate
	
from film fi inner join inventory iv
on fi.film_id = iv.film_id inner join rental rn
on iv.inventory_id = rn.inventory_id inner join customer cu
on rn.customer_id = cu.customer_id inner join address ad
on cu.address_id = ad.address_id inner join city ct
on ad.city_id = ct.city_id inner join country co
on ct.country_id = co.country_id

group by fi.rental_rate
order by customer_count desc