-- 1
DROP INDEX "INDEX_ZACTIVITY_ACTIVITIES";
DROP INDEX "INDEX_ZROOMTYPES_ROOMTYPE";
CREATE BITMAP INDEX INDEX_ZACTIVITY_ACTIVITIES ON ZACTIVITIES (REF, ACTIVITY);
CREATE BITMAP INDEX INDEX_ZROOMTYPES_ROOMTYPE ON ZROOMTYPES (ROOMTYPE, DESCRIPTION);
-- 2
DROP INDEX "INDEX_ZROOMTYPES_ROOMTYPE";
DROP INDEX "INDEX_ZREGIONS_DESIGNATION";
DROP INDEX "INDEX_ZMUNICIPALITIES_REGION";
CREATE BITMAP INDEX INDEX_ZROOMTYPES_ROOMTYPE ON ZROOMTYPES (ROOMTYPE, DESCRIPTION);
CREATE UNIQUE INDEX INDEX_ZREGIONS_DESIGNATION ON ZREGIONS (COD ASC, DESIGNATION ASC);
CREATE UNIQUE INDEX INDEX_ZMUNICIPALITIES_REGION ON ZMUNICIPALITIES (COD ASC, REGION ASC);

-- 3
DROP INDEX "INDEX_ZACTIVITY_ACTIVITIES";
DROP INDEX "INDEX_ZFACILITIES_MUNICIPALITY";
DROP INDEX "INDEX_ZMUNICIPALITIES_REGION";
CREATE BITMAP INDEX INDEX_ZACTIVITY_ACTIVITIES ON ZACTIVITIES (REF, ACTIVITY);
CREATE UNIQUE INDEX INDEX_ZFACILITIES_MUNICIPALITY ON ZFACILITIES (ID ASC, MUNICIPALITY ASC);
CREATE UNIQUE INDEX INDEX_ZMUNICIPALITIES_REGION ON ZMUNICIPALITIES (COD ASC, REGION ASC);

-- 6
DROP INDEX "INDEX_ZFACILITIES_MUNICIPALITY";
DROP INDEX "INDEX_ZMUNICIPALITIES_DISTRICT";
DROP INDEX "INDEX_ZDISTRICTS_COD";
CREATE UNIQUE INDEX INDEX_ZFACILITIES_MUNICIPALITY ON ZFACILITIES (ID ASC, MUNICIPALITY ASC);
CREATE UNIQUE INDEX INDEX_ZMUNICIPALITIES_DISTRICT ON ZMUNICIPALITIES (COD ASC, DISTRICT ASC);
CREATE UNIQUE INDEX INDEX_ZDISTRICTS_COD ON ZDISTRICTS (COD ASC, DESIGNATION ASC);
