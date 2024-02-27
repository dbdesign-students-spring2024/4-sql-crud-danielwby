--Delete all restaurants that are not good for kids.
DELETE FROM restaurant
WHERE Good_for_kids = 'FALSE';