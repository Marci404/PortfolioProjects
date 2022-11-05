SELECT *
FROM dataset_1
WHERE passanger = 'Alone'--ello
AND destination = 'Home'
AND weather = 'Rainy'
ORDER BY time ASC;

SELECT destination, time, passanger , temperature ,
AVG(temperature ), 
SUM(temperature ), 
COUNT(temperature )
FROM dataset_1 d 
WHERE time != '10PM'
GROUP BY destination, time;

SELECT *
FROM dataset_1 d 
UNION
SELECT *
FROM 
table_to_union;

SELECT DISTINCT destination
FROM 
(SELECT *
FROM dataset_1 d 
UNION
SELECT *
FROM 
table_to_union);

SELECT *
FROM table_to_join ttj 

SELECT destination, d.time, ttj.part_of_day  
from dataset_1 d 
left join table_to_join ttj 
on d.time = ttj.part_of_day ;

SELECT *
FROM dataset_1 d 
WHERE weather LIKE 'Sun%'

SELECT *
FROM dataset_1 d 
WHERE time like '%PM'
LIMIT 200

SELECT DISTINCT temperature
from dataset_1 d 
WHERE temperature BETWEEN 20 and 105;


SELECT 
	destination, 
	weather, 
	AVG(temperature) OVER (PARTITION BY weather) AS 'avg_temp_by_weather'
FROM dataset_1;
