-- create table restaurant
create table restaurant
(
	ID INTEGER not null,
	food_Category TEXT not null,
	Price_tier TEXT not null,
	Neighborhood TEXT not null,
	Opening_hours time not null,
	Average_rating INTEGER not null,
	Good_for_kids boolean not null
);

-- create table reviews
create table reviews
(
	ID INTEGER not null,
	reviews TEXT
);

/*
-- import csv file
.mode csv
.import restaurants.csv restaurant

*/

--1.Find all cheap restaurants in a particular neighborhood(Manhattan)
SELECT *
FROM restaurant
WHERE Neighborhood = 'Manhattan' AND Price_tier = 'cheap'

--2.Find all restaurants in a particular genre (Western food) with 3 stars or more,
--ordered by the number of stars in descending order.
SELECT *
FROM restaurant
WHERE food_Category = 'Western food' AND Average_rating >= 3 ORDER BY Average_rating DESC

--3.Find all restaurants that are open now (see hint below).
SELECT *
FROM restaurant
WHERE Opening_hours <= strftime('%H:%M', 'now')
ORDER BY Opening_hours ASC;

--4.The restaurant with ID 1 is selected for evaluation
insert into reviews
values (1,'This restaurant is very good and I recommend it')

--5.Delete all restaurants that are not good for kids.
DELETE FROM restaurant
WHERE Good_for_kids = 'FALSE';

--6.Find the number of restaurants in each NYC neighborhood.
SELECT Neighborhood, COUNT(*) AS Num_restaurants
FROM restaurant
GROUP BY Neighborhood;