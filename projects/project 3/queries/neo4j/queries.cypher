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
