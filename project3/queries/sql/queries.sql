-- A
SELECT id, name, description, activity
FROM facilities NATURAL JOIN roomtypes NATURAL JOIN uses NATURAL JOIN activities
WHERE description  LIKE '%touros%' AND activity = 'teatro';

-- B
SELECT regions.designation, count(*)
FROM facilities NATURAL JOIN roomtypes INNER JOIN municipalities
ON municipalities.cod = facilities.municipality
INNER JOIN regions ON municipalities.region = regions.cod
WHERE description  LIKE '%touros%'
GROUP BY regions.designation;

-- C
SELECT count(*) FROM
municipalities
WHERE cod NOT IN
(SELECT municipality
FROM facilities NATURAL JOIN uses NATURAL JOIN activities
INNER JOIN
municipalities ON municipalities.cod = facilities.municipality
WHERE activity = 'cinema');

-- D
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

-- E
SELECT designation,cod FROM districts WHERE cod NOT IN
(
SELECT
     districts.cod
FROM municipalities INNER JOIN districts ON municipalities.district = districts.cod
LEFT OUTER JOIN facilities on facilities.municipality = municipalities.cod
WHERE id is null
);

-- F
SELECT d.cod,d.designation, ROUND(AVG(f.capacity),2) AS Avg_Cap_Per_District
FROM districts d, municipalities m, facilities f
WHERE m.district = d.cod AND f.municipality = m.cod
GROUP BY d.cod,d.designation;