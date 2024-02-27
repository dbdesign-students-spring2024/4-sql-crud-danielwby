--Find the number of restaurants in each NYC neighborhood.
SELECT Neighborhood, COUNT(*) AS Num_restaurants
FROM restaurant
GROUP BY Neighborhood;