DELETE FROM regions;
DELETE FROM districts;
DELETE FROM municipalities;
DELETE FROM roomtypes;
DELETE FROM facilities;
DELETE FROM activities;

INSERT INTO regions (COD, DESIGNATION, NUT1)
SELECT COD, DESIGNATION, NUT1 FROM gtd8.regions;

INSERT INTO districts (COD, DESIGNATION, REGION)
SELECT d.COD, d.DESIGNATION, (SELECT ref(r) FROM regions r WHERE r.COD = d.REGION)
FROM gtd8.districts d;

INSERT INTO municipalities (COD, DESIGNATION, DISTRICT, REGION)
SELECT m.COD, m.DESIGNATION, (SELECT ref(d) FROM districts d WHERE d.COD = m.DISTRICT), (SELECT ref(r) FROM regions r WHERE r.COD = m.REGION)
FROM gtd8.municipalities m;

INSERT INTO roomtypes (ROOMTYPE, DESCRIPTION)
SELECT rt.ROOMTYPE, rt.DESCRIPTION
FROM gtd8.roomtypes rt;

INSERT INTO facilities (ID, NAME, CAPACITY, ROOMTYPE, ADDRESS, MUNICIPALITY)
SELECT f.ID, f.NAME, f.CAPACITY, (SELECT ref(rt) FROM roomtypes rt WHERE rt.ROOMTYPE = f.ROOMTYPE), f.ADDRESS, (SELECT ref(m) FROM municipalities m WHERE m.COD = f.MUNICIPALITY)
FROM gtd8.facilities f;

INSERT INTO activities (REF, ACTIVITY)
SELECT a.REF, a.ACTIVITY
FROM gtd8.activities a;

-------------------------------

------- Nested Tables ---------

-------------------------------

-- Facilities Activities
UPDATE facilities f
SET f.activities =
CAST(MULTISET(SELECT REF(a) FROM activities a JOIN gtd8.Uses u ON a.ref = u.ref WHERE u.id = f.id) AS activitiesref_tab_t);

-- Activities Facilities
UPDATE activities a
SET a.facilities =
CAST(MULTISET(SELECT REF(f) FROM facilities f JOIN gtd8.Uses u ON a.ref = u.ref WHERE u.id = f.id) AS facilitiesref_tab_t);

-- Municipalities Facilities
UPDATE municipalities m
SET m.Facilities =
CAST(MULTISET(SELECT REF(f) FROM facilities f WHERE m.cod = f.municipality.cod) AS facilitiesref_tab_t);

-- Districts Municipalities
UPDATE districts d
SET d.Municipalities =
CAST(MULTISET(SELECT REF(m) FROM municipalities m WHERE d.cod = m.district.cod) AS municipalitiesref_tab_t);

-- Regions Districts
UPDATE regions r
SET r.Districts =
CAST(MULTISET(SELECT REF(d) FROM districts d WHERE r.cod = d.region.cod) AS districtsref_tab_t);

-- Regions Municipalities
UPDATE regions r
SET r.Municipalities =
CAST(MULTISET(SELECT REF(m) FROM municipalities m WHERE r.cod = m.region.cod) AS municipalitiesref_tab_t);