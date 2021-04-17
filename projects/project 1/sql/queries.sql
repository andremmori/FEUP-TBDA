-- 1
SELECT id, name, description, activity
FROM xfacilities NATURAL JOIN xroomtypes NATURAL JOIN xuses NATURAL JOIN xactivities
WHERE description  LIKE '%touros%' AND activity = 'teatro';

-- 2
SELECT xregions.designation, count(*)
FROM xfacilities NATURAL JOIN xroomtypes INNER JOIN xmunicipalities
ON xmunicipalities.cod = xfacilities.municipality
INNER JOIN xregions ON xmunicipalities.region = xregions.cod
WHERE description  LIKE '%touros%'
GROUP BY xregions.designation;

-- 3
---- a)
SELECT count(*) FROM
xmunicipalities
WHERE cod NOT IN
(SELECT municipality
FROM xfacilities NATURAL JOIN xuses NATURAL JOIN xactivities
INNER JOIN
xmunicipalities ON xmunicipalities.cod = xfacilities.municipality
WHERE activity = 'cinema');


---- b)
SELECT count(*)
FROM xmunicipalities LEFT OUTER JOIN (SELECT municipality as cod, activity
FROM xfacilities NATURAL JOIN xuses NATURAL JOIN xactivities
INNER JOIN
xmunicipalities ON xmunicipalities.cod = xfacilities.municipality
WHERE activity = 'cinema') cinemas
ON xmunicipalities.cod = cinemas.cod
WHERE activity IS NULL;

-- 4
SELECT q2.designation, q1.activity, q1.facilities
FROM (SELECT activity, max(facilities) as facilities
FROM (SELECT municipality, activity, count(*) as facilities
FROM xfacilities NATURAL JOIN xuses NATURAL JOIN xactivities
GROUP BY municipality, activity)
GROUP BY activity) q1 LEFT JOIN (SELECT designation, activity, count(*) as facilities
FROM xmunicipalities INNER JOIN xfacilities NATURAL JOIN xuses NATURAL JOIN xactivities
ON xmunicipalities.cod = xfacilities.municipality
GROUP BY designation, activity) q2
ON q2.activity = q1.activity AND q2.facilities = q1.facilities;

-- 5

SELECT zmunicipalities.designation, zfacilities.name, zroomtypes.description
FROM zfacilities NATURAL JOIN zroomtypes INNER JOIN zmunicipalities On
zmunicipalities.cod = zfacilities.municipality INNER JOIN zdistricts ON
zdistricts.cod = zmunicipalities.district
WHERE zdistricts.designation = 'Porto' AND zroomtypes.description  LIKE '%touros%';
/*
Add on question 5 a)
CREATE INDEX INDEX_B_TREE ON ZFACILITIES (ROOMTYPE , MUNICIPALITY );

Add on question 5 a) b)
CREATE BITMAP INDEX INDEX_BITMAP ON ZFACILITIES (ROOMTYPE, MUNICIPALITY);
*/

-- 6
SELECT designation,cod FROM xdistricts WHERE cod NOT IN
(
SELECT
     xdistricts.cod
FROM xmunicipalities INNER JOIN xdistricts ON xmunicipalities.district = xdistricts.cod
LEFT OUTER JOIN xfacilities on xfacilities.municipality = xmunicipalities.cod
WHERE id is null
);