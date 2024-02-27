--Find all cheap restaurants in a particular neighborhood(Manhattan)
SELECT *
FROM restaurant
WHERE Neighborhood = 'Manhattan' AND Price_tier = 'cheap'