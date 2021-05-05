-- 1
SELECT f.id, f.name, f.roomtype.description, VALUE(a).activity
FROM facilities f, TABLE(f.activities) a
WHERE f.roomtype.description LIKE '%touros%' AND VALUE(a).activity = 'teatro';

---- 1 with functions
SELECT f.id, f.name, f.roomtype.description, VALUE(a).activity
FROM facilities f, TABLE(f.activities) a
WHERE f.roomtype.descriptionContains('touros') = 'TRUE'
AND a.isActivity('teatro') = 'TRUE';

-- 2
SELECT r.cod, r.designation, COALESCE(info.n_facilities, 0) n_facilities
FROM regions r LEFT OUTER JOIN
(
    SELECT r.cod, r.designation, COUNT(VALUE(f).ID) n_facilities
    FROM regions r, TABLE(r.municipalities) m, TABLE(VALUE(m).facilities) f
    WHERE VALUE(f).roomtype.description LIKE '%touros%'
    GROUP BY r.cod, r.designation
    ORDER BY r.cod
) info
ON r.cod = info.cod;

---- 2 with functions
SELECT r.cod, r.designation, COALESCE(info.n_facilities, 0) n_facilities
FROM regions r LEFT OUTER JOIN
(
    SELECT r.cod, r.designation, COUNT(VALUE(f).ID) n_facilities
    FROM regions r, TABLE(r.municipalities) m, TABLE(VALUE(m).facilities) f
    WHERE VALUE(f).roomtype.descriptionContains('touros') = 'TRUE'
    GROUP BY r.cod, r.designation
    ORDER BY r.cod
) info
ON r.cod = info.cod;

-- 3
SELECT COUNT(m.cod)
FROM municipalities m
WHERE m.cod NOT IN
(
    SELECT m.cod FROM municipalities m, TABLE(m.facilities) f, TABLE(VALUE(f).activities) a
    WHERE VALUE(a).activity = 'cinema'
);

---- 3 with functions
SELECT COUNT(m.cod) FROM municipalities m WHERE m.municipalityHasActivity('cinema') = 0;

-- 4
SELECT t1.*
FROM
(
    SELECT VALUE(a).ACTIVITY activity, m.COD, m.DESIGNATION, COUNT(VALUE(f).ID) n_facilities
    FROM municipalities m, TABLE(m.facilities) f, TABLE(VALUE(f).activities) a
    GROUP BY VALUE(a).ACTIVITY, m.COD, m.DESIGNATION
) t1
LEFT OUTER JOIN
(
    SELECT VALUE(a).ACTIVITY activity, m.COD, m.DESIGNATION, COUNT(VALUE(f).ID) n_facilities
    FROM municipalities m, TABLE(m.facilities) f, TABLE(VALUE(f).activities) a
    GROUP BY VALUE(a).ACTIVITY, m.COD, m.DESIGNATION
) t2 ON (t1.activity = t2.activity AND t1.n_facilities < t2.n_facilities)
WHERE t2.ACTIVITY IS NULL
ORDER BY t1.ACTIVITY;

-- 5
SELECT cod, designation
FROM districts
WHERE cod NOT IN
(
    SELECT DISTINCT d.cod
    FROM districts d, TABLE(d.municipalities) m
    WHERE (d.cod, VALUE(m).cod) NOT IN
    (
        SELECT d.cod, VALUE(m).cod
        FROM districts d, TABLE(d.municipalities) m, TABLE(VALUE(m).facilities) f
    )
) ORDER BY cod;
