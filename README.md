# Task 1
[Source data](/data/restaurants.csv)
## Creating the restaurant table
````
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
````
## Creating the reviews table
````
create table reviews
(
	ID INTEGER not null,
	reviews TEXT
);
````