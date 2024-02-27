--Find all restaurants in a particular genre (Western food) with 3 stars or more,
--ordered by the number of stars in descending order.
SELECT *
FROM restaurant
WHERE food_Category = 'Western food' AND Average_rating >= 3 ORDER BY Average_rating DESC