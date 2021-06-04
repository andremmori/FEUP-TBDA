// A
MATCH (f:Facilities)-[:FACILITY_ROOMTYPE]-(rt:Roomtypes)
MATCH (f)-[:FACILITY_ACTIVITY]-(a:Activities)
WHERE rt.DESCRIPTION CONTAINS 'touros' AND a.ACTIVITY = 'teatro'
RETURN f.ID AS ID, f.NAME AS NAME, rt.DESCRIPTION AS DESCRIPTION, a.ACTIVITY AS ACTIVITY;

// B
MATCH (f:Facilities)-[:FACILITY_MUNICIPALITY]->(m:Municipalities)
MATCH (m)-[:MUNICIPALITY_REGION]->(r:Regions)
MATCH (f)-[:FACILITY_ROOMTYPE]->(rt:Roomtypes)
WHERE rt.DESCRIPTION CONTAINS 'touros'
RETURN r.DESIGNATION AS DESIGNATION, COUNT(r.DESIGNATION) AS N_FACILITIES;

// C
MATCH (f:Facilities)-[:FACILITY_ACTIVITY]->(a:Activities)
WHERE a.ACTIVITY = 'cinema'
MATCH (f)-[:FACILITY_MUNICIPALITY]->(m:Municipalities)
WITH COUNT(DISTINCT m.COD) AS municipalitiesWithCinema
MATCH (totalMunicipalities:Municipalities)
RETURN COUNT(totalMunicipalities) - municipalitiesWithCinema AS Total;

// D
MATCH (f:Facilities)-[:FACILITY_ACTIVITY]->(a:Activities)
MATCH (f)-[:FACILITY_MUNICIPALITY]->(m:Municipalities)
WITH m.DESIGNATION AS DESIGNATION, a.ACTIVITY AS ACTIVITY,  COUNT(a) AS TOTAL
WITH COLLECT({municipality: DESIGNATION, activity: ACTIVITY, total: TOTAL}) AS ROWS, MAX(TOTAL) AS MAX, ACTIVITY AS activity
UNWIND [ROW IN ROWS WHERE ROW.activity = activity AND ROW.total = MAX] AS ROW
RETURN  ROW.activity AS ACTIVITY, ROW.municipality AS MUNICIPALITY, ROW.total AS N_FACILITIES;

// E
MATCH (m)-[:MUNICIPALITY_DISTRICT]-(d:Districts)
OPTIONAL MATCH (f)-[:FACILITY_MUNICIPALITY]->(m)
WITH d as District, m.COD as M, f.ID as Facility
WHERE Facility is NULL
MATCH (d:Districts)
WITH COLLECT(DISTINCT District) AS withoutAllFacilities, COLLECT(DISTINCT d) AS allDistricts
WITH [n IN allDistricts WHERE NOT n IN withoutAllFacilities] AS withAllFacilities
UNWIND withAllFacilities as resDistricts
RETURN resDistricts.COD AS COD, resDistricts.DESIGNATION AS DESIGNATION;

// F
MATCH (f:Facilities)-[:FACILITY_ACTIVITY]->(a:Activities)
MATCH (f)-[:FACILITY_MUNICIPALITY]->(m:Municipalities)
MATCH (m)-[:MUNICIPALITY_DISTRICT]->(d:Districts)
WITH d AS d, m.COD AS m, COUNT(distinct f.ID) AS diffFacilities, COUNT(a.REF) AS activities
RETURN d.COD AS COD, d.DESIGNATION AS DESIGNATION, AVG(activities/diffFacilities) AS avgActivitiesPerFacility
ORDER BY COD;
