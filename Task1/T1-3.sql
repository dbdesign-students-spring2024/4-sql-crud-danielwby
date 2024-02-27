--Find all restaurants that are open now (see hint below).
SELECT *
FROM restaurant
WHERE Opening_hours <= strftime('%H:%M', 'now')
ORDER BY Opening_hours ASC;