// Drop all
MATCH (n)
DETACH DELETE n;

// Region
LOAD CSV WITH HEADERS FROM 'file:///REGIONS_DATA.csv' AS row
CREATE (:Regions { COD: toInteger(row.COD), DESIGNATION: row.DESIGNATION, NUT1: row.NUT1});

// District
LOAD CSV WITH HEADERS FROM 'file:///DISTRICTS_DATA.csv' AS row
CREATE (d:Districts { COD: toInteger(row.COD), DESIGNATION: row.DESIGNATION, REGION: toInteger(row.REGION)});

// DISTRICT_REGION Relation
MATCH ( d:Districts)
MATCH ( r:Regions { COD : toInteger(d.REGION)})
CREATE (d)-[:DISTRICT_REGION]->(r);

// Municipalities
LOAD CSV WITH HEADERS FROM 'file:///MUNICIPALITIES_DATA.csv' AS row
CREATE (:Municipalities { COD: toInteger(row.COD), DESIGNATION: row.DESIGNATION, DISTRICT: toInteger(row.DISTRICT), REGION: toInteger(row.REGION)});

// MUNICIPALITY_DISTRICT
MATCH (m:Municipalities)
MATCH (d:Districts { COD : toInteger(m.DISTRICT)})
CREATE (m)-[:MUNICIPALITY_DISTRICT]->(d);

// MUNICIPALITY_REGION
// MATCH (m:Municipalities)
// MATCH (r:Regions { COD : toInteger(m.REGION)})
// CREATE (m)-[:MUNICIPALITY_REGION]->(r);

// Facilities
LOAD CSV WITH HEADERS FROM 'file:///FACILITIES_DATA.csv' AS row
CREATE (:Facilities { ID: toInteger(row.ID), NAME: row.NAME, CAPACITY: toInteger(row.CAPACITY), ROOMTYPE: toInteger(row.ROOMTYPE), ADDRESS: row.ADDRESS, MUNICIPALITY: toInteger(row.MUNICIPALITY)});

// Roomtypes
LOAD CSV WITH HEADERS FROM 'file:///ROOMTYPES_DATA.csv' AS row
CREATE (:Roomtypes { ROOMTYPE: toInteger(row.ROOMTYPE), DESCRIPTION: row.DESCRIPTION});

// FACILITY_ROOMTYPE
MATCH (f:Facilities)
MATCH (rt: Roomtypes { ROOMTYPE: toInteger(f.ROOMTYPE)})
CREATE (f)-[:FACILITY_ROOMTYPE]->(rt);

// Activities
LOAD CSV WITH HEADERS FROM 'file:///ACTIVITIES_DATA.csv' AS row
CREATE (:Activities { REF: toInteger(row.REF), ACTIVITY: row.ACTIVITY});

// FACILITY_ACTIVITY
LOAD CSV WITH HEADERS FROM 'file:///USES_DATA.csv' AS row
MATCH (f:Facilities { ID: toInteger(row.ID)})
MATCH (a:Activities { REF: toInteger(row.REF)})
CREATE (f)-[:FACILITY_ACTIVITY]->(a);