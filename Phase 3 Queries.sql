-- Given a username or email address, is that user in the database?
select count(email) = 1 as contains_user from user where email = 'fakeemail@gmail.com'; -- Value chosen arbitrarily

-- Given a username or email address, is that user an admin user?
select is_admin from user where email = (select email from user limit 1); -- Value chosen arbitrarily as first user email

-- Which attractions are open right now in Paris?
select attraction.*
from attraction join open_times using (name)
where attraction.city = 'Paris' and attraction.country = 'France' and open_times.day_of_week = dayofweek(now())
	and open_times.open_time < time(now()) and open_times.close_time > time(now());
    
-- Which attractions in Paris don't require reservations?
select * from attraction
where city = 'Paris' and country = 'France' and !requires_reservation;

-- Which attractions in Metz are free?
select * from attraction where price = 0 and city = 'Metz' and country = 'France';

-- Show the details for one attraction?
select * from attraction limit 1; -- First attraction selected

-- List all the reviews for an attraction.
select review.* 
from attraction join review on attraction.name = review.attraction
where attraction.name = 'Macaron Class'; -- Value chosen arbitrarily

-- List all the reviews written by a particular user.
select review.* from review join user using (email)
where email = 'fakeemail@gmail.com'; -- Value chosen arbitrarily

-- Show the details of one review.
select * from review limit 1;

-- List the trips in the database for a particular user.
select trip.* from trip join user on user.email = trip.trip_user
where user.email = 'fakeemail@gmail.com'; -- Value chosen arbitrarily 

-- For an attraction that requires reservations and already
-- has some reservations for a time slot, how many spots
-- remain for that time slot?
select attraction.capacity - sum(number_in_party) as spots_remaining
from attraction join activity on attraction.name = activity.attraction_name
	join reservation using (reservation_id)
where attraction.name = 'Macaron Class' and reservation.start_date_time = '2018-07-06 15:00:00'
	and reservation.end_date_time = '2018-07-06 18:00:00'; -- Values chosen arbitrarily
    
-- For one of the trips in the database that has two more
-- more paid activities, what is the total cost of the trip?
select sum_price 
from (select sum(attraction.price) as sum_price, count(trip_id) as trip_count
		from trip join activity using (trip_id) 
		join attraction on attraction.name = activity.attraction_name
	group by trip_id) as price_count
where trip_count >= 2
limit 1;

-- For one of the public transportation locations in your database, 
-- which attractions are nearest to that location
-- (list it as the nearest public transportation)?
select * from attraction
where nearest_public_trans = (select name from public_trans limit 1); -- Value chosen arbitrarily as first in public_trans list