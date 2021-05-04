DROP TABLE "ACTIVITIES" CASCADE CONSTRAINTS;
DROP TABLE "DISTRICTS" CASCADE CONSTRAINTS;
DROP TABLE "FACILITIES" CASCADE CONSTRAINTS;
DROP TABLE "MUNICIPALITIES" CASCADE CONSTRAINTS;
DROP TABLE "REGIONS" CASCADE CONSTRAINTS;
DROP TABLE "ROOMTYPES" CASCADE CONSTRAINTS;

----------------------------

------- Type Creation ------

----------------------------
DROP TYPE region_t FORCE;
DROP TYPE district_t FORCE;
DROP TYPE districtsref_tab_t FORCE;
DROP TYPE municipality_t FORCE;
DROP TYPE municipalitiesref_tab_t FORCE;
DROP TYPE roomtype_t FORCE;
DROP TYPE facility_t FORCE;
DROP TYPE facilitiesref_tab_t FORCE;
DROP TYPE activity_t FORCE;
DROP TYPE activitiesref_tab_t FORCE;

CREATE OR REPLACE TYPE region_t AS OBJECT (
    cod NUMBER(4, 0),
    designation	VARCHAR2(50 BYTE),
    nut1 VARCHAR2(50 BYTE)
);

CREATE OR REPLACE TYPE district_t AS OBJECT
(
    cod	NUMBER(4,0),
    designation	VARCHAR2(50 BYTE),
    region REF region_t
);

CREATE OR REPLACE TYPE districtsref_tab_t AS TABLE OF REF district_t;

CREATE OR REPLACE TYPE municipality_t AS OBJECT
(
    cod	NUMBER(4,0),
    designation	VARCHAR2(50 BYTE),
    district REF district_t,
    region REF region_t
);

CREATE OR REPLACE TYPE municipalitiesref_tab_t AS TABLE OF REF municipality_t;

CREATE OR REPLACE TYPE roomtype_t AS OBJECT
(
    roomtype NUMBER(4,0),
    description VARCHAR2(50 BYTE)
);

CREATE OR REPLACE TYPE facility_t AS OBJECT
(
    id NUMBER(4,0),
    name VARCHAR2(80),
    capacity NUMBER(8,0),
    roomtype REF roomtype_t,
    address VARCHAR2(80),
    municipality REF municipality_t
);

CREATE OR REPLACE TYPE facilitiesref_tab_t AS TABLE OF REF facility_t;

CREATE OR REPLACE TYPE activity_t AS OBJECT
(
    ref VARCHAR2(20),
    activity VARCHAR2(20)
);

CREATE OR REPLACE TYPE activitiesref_tab_t AS TABLE OF REF activity_t;

ALTER TYPE region_t
ADD ATTRIBUTE (districts districtsref_tab_t) CASCADE;

ALTER TYPE region_t
ADD ATTRIBUTE (municipalities municipalitiesref_tab_t) CASCADE;

ALTER TYPE district_t
ADD ATTRIBUTE (municipalities municipalitiesref_tab_t) CASCADE;

ALTER TYPE municipality_t
ADD ATTRIBUTE (facilities facilitiesref_tab_t) CASCADE;

ALTER TYPE facility_t
ADD ATTRIBUTE (activities activitiesref_tab_t) CASCADE;

ALTER TYPE activity_t
ADD ATTRIBUTE (facilities facilitiesref_tab_t) CASCADE;

----------------------------

------ Table Creation ------

----------------------------

CREATE TABLE regions OF region_t
    NESTED TABLE districts STORE AS region_districts
    NESTED TABLE municipalities STORE AS region_municipalities;

CREATE TABLE districts OF district_t
    NESTED TABLE municipalities STORE AS district_municipalities;

CREATE TABLE municipalities OF municipality_t
    NESTED TABLE facilities STORE AS municipality_facilities;

CREATE TABLE roomtypes OF roomtype_t;

CREATE TABLE facilities OF facility_t
    NESTED TABLE activities STORE AS facility_activities;

CREATE TABLE activities OF activity_t
    NESTED TABLE facilities STORE AS activity_facilities;


------------------------

------ FUNCTION --------

------------------------
ALTER TYPE activity_t
ADD MEMBER FUNCTION isActivity(word STRING) RETURN STRING CASCADE;
ALTER TYPE roomtype_t
ADD MEMBER FUNCTION descriptionContains(word STRING) RETURN STRING CASCADE;

CREATE OR REPLACE TYPE BODY activity_t AS
    MEMBER FUNCTION isActivity(word STRING) RETURN STRING IS
    BEGIN
        IF activity = word THEN
            RETURN 'TRUE';
        ELSE
            RETURN 'FALSE';
        END IF;
    END isActivity;
END;

CREATE OR REPLACE TYPE BODY roomtype_t AS
    MEMBER FUNCTION descriptionContains(word STRING) RETURN STRING IS
    BEGIN
        IF description LIKE '%' || word || '%' THEN
            RETURN 'TRUE';
        ELSE
            RETURN 'FALSE';
        END IF;
    END descriptionContains;
END;