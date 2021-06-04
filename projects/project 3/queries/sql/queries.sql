-- 1
SELECT id, name, description, activity
FROM facilities NATURAL JOIN roomtypes NATURAL JOIN uses NATURAL JOIN activities
WHERE description  LIKE '%touros%' AND activity = 'teatro';

-- 2
SELECT regions.designation, count(*)
FROM facilities NATURAL JOIN roomtypes INNER JOIN municipalities
ON municipalities.cod = facilities.municipality
INNER JOIN regions ON municipalities.region = regions.cod
WHERE description  LIKE '%touros%'
GROUP BY regions.designation;

-- 3
---- a)
SELECT count(*) FROM
municipalities
WHERE cod NOT IN
(SELECT municipality
FROM facilities NATURAL JOIN uses NATURAL JOIN activities
INNER JOIN
municipalities ON municipalities.cod = facilities.municipality
WHERE activity = 'cinema');


---- b)
SELECT count(*)
FROM municipalities LEFT OUTER JOIN (SELECT municipality as cod, activity
FROM facilities NATURAL JOIN uses NATURAL JOIN activities
INNER JOIN
municipalities ON municipalities.cod = facilities.municipality
WHERE activity = 'cinema') cinemas
ON municipalities.cod = cinemas.cod
WHERE activity IS NULL;

-- 4
SELECT q2.designation, q1.activity, q1.facilities
FROM (SELECT activity, max(facilities) as facilities
FROM (SELECT municipality, activity, count(*) as facilities
FROM facilities NATURAL JOIN uses NATURAL JOIN activities
GROUP BY municipality, activity)
GROUP BY activity) q1 LEFT JOIN (SELECT designation, activity, count(*) as facilities
FROM municipalities INNER JOIN facilities NATURAL JOIN uses NATURAL JOIN activities
ON municipalities.cod = facilities.municipality
GROUP BY designation, activity) q2
ON q2.activity = q1.activity AND q2.facilities = q1.facilities;

-- 5

SELECT municipalities.designation, facilities.name, roomtypes.description
FROM facilities NATURAL JOIN roomtypes INNER JOIN municipalities On
municipalities.cod = facilities.municipality INNER JOIN districts ON
districts.cod = municipalities.district
WHERE districts.designation = 'Porto' AND roomtypes.description  LIKE '%touros%';

-- 6
SELECT designation,cod FROM districts WHERE cod NOT IN
(
SELECT
     districts.cod
FROM municipalities INNER JOIN districts ON municipalities.district = districts.cod
LEFT OUTER JOIN facilities on facilities.municipality = municipalities.cod
WHERE id is null
);

-- 7
SELECT d.cod,d.designation, ROUND(AVG(f.capacity),2) AS Avg_Cap_Per_District
FROM districts d, municipalities m, facilities f
WHERE m.district = d.cod AND f.municipality = m.cod
GROUP BY d.cod,d.designation;