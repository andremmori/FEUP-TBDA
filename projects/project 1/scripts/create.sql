/*
    CHANGE XXXXXXXXX TO YOUR STUDENT NUMBER
*/


--  Tables
create table "UPXXXXXXXXX".XACTIVITIES as select * from "GTD8"."ACTIVITIES";
create table "UPXXXXXXXXX".XDISTRICTS as select * from "GTD8"."DISTRICTS";
create table "UPXXXXXXXXX".XFACILITIES as select * from "GTD8"."FACILITIES";
create table "UPXXXXXXXXX".XMUNICIPALITIES as select * from "GTD8"."MUNICIPALITIES";
create table "UPXXXXXXXXX".XREGIONS as select * from "GTD8"."REGIONS";
create table "UPXXXXXXXXX".XROOMTYPES as select * from "GTD8"."ROOMTYPES";
create table "UPXXXXXXXXX".XUSES as select * from "GTD8"."USES";

create table "UPXXXXXXXXX".YACTIVITIES as select * from "GTD8"."ACTIVITIES";
create table "UPXXXXXXXXX".YDISTRICTS as select * from "GTD8"."DISTRICTS";
create table "UPXXXXXXXXX".YFACILITIES as select * from "GTD8"."FACILITIES";
create table "UPXXXXXXXXX".YMUNICIPALITIES as select * from "GTD8"."MUNICIPALITIES";
create table "UPXXXXXXXXX".YREGIONS as select * from "GTD8"."REGIONS";
create table "UPXXXXXXXXX".YROOMTYPES as select * from "GTD8"."ROOMTYPES";
create table "UPXXXXXXXXX".YUSES as select * from "GTD8"."USES";

create table "UPXXXXXXXXX".ZACTIVITIES as select * from "GTD8"."ACTIVITIES";
create table "UPXXXXXXXXX".ZDISTRICTS as select * from "GTD8"."DISTRICTS";
create table "UPXXXXXXXXX".ZFACILITIES as select * from "GTD8"."FACILITIES";
create table "UPXXXXXXXXX".ZMUNICIPALITIES as select * from "GTD8"."MUNICIPALITIES";
create table "UPXXXXXXXXX".ZREGIONS as select * from "GTD8"."REGIONS";
create table "UPXXXXXXXXX".ZROOMTYPES as select * from "GTD8"."ROOMTYPES";
create table "UPXXXXXXXXX".ZUSES as select * from "GTD8"."USES";


-- Primary Keys
alter table "UPXXXXXXXXX"."YREGIONS" add constraint YREGIONS_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."YDISTRICTS" add constraint YDISTRICTS_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."YMUNICIPALITIES" add constraint YMUNICIPALITIES_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."YFACILITIES" add constraint YFACILITIES_ID_PK primary key("ID");
alter table "UPXXXXXXXXX"."YROOMTYPES" add constraint YROOMTYPES_ROOMTYPES_PK primary key("ROOMTYPE");
alter table "UPXXXXXXXXX"."YACTIVITIES" add constraint YACTIVITIES_REF_PK primary key("REF");
alter table "UPXXXXXXXXX"."YUSES" add constraint YUSES_ID_REF_PK primary key("ID","REF");
alter table "UPXXXXXXXXX"."ZREGIONS" add constraint ZREGIONS_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."ZDISTRICTS" add constraint ZDISTRICTS_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."ZMUNICIPALITIES" add constraint ZMUNICIPALITIES_COD_PK primary key("COD");
alter table "UPXXXXXXXXX"."ZFACILITIES" add constraint ZFACILITIES_ID_PK primary key("ID");
alter table "UPXXXXXXXXX"."ZROOMTYPES" add constraint ZROOMTYPES_ROOMTYPES_PK primary key("ROOMTYPE");
alter table "UPXXXXXXXXX"."ZACTIVITIES" add constraint ZACTIVITIES_REF_PK primary key("REF");
alter table "UPXXXXXXXXX"."ZUSES" add constraint ZUSES_ID_REF_PK primary key("ID","REF");


-- Foreign Keys
alter table "UPXXXXXXXXX"."YDISTRICTS" add constraint YDISTRICTS_REGION_FK foreign key("REGION") references "YREGIONS"("COD");
alter table "UPXXXXXXXXX"."YMUNICIPALITIES" add constraint YMUNICIPALITIES_REGION_FK foreign key("REGION") references "YREGIONS"("COD");
alter table "UPXXXXXXXXX"."YMUNICIPALITIES" add constraint YMUNICIPALITIES_DISTRICT_FK foreign key("DISTRICT") references "YDISTRICTS"("COD");
alter table "UPXXXXXXXXX"."YFACILITIES" add constraint YFACILITIES_MUNICIPALITY_FK foreign key("MUNICIPALITY") references "YMUNICIPALITIES"("COD");
alter table "UPXXXXXXXXX"."YFACILITIES" add constraint YFACILITIES_ROOMTYPE_FK foreign key("ROOMTYPE") references "YROOMTYPES"("ROOMTYPE");
alter table "UPXXXXXXXXX"."YUSES" add constraint YUSES_ID_FK foreign key("ID") references "YFACILITIES"("ID");
alter table "UPXXXXXXXXX"."YUSES" add constraint YUSES_REF_FK foreign key("REF") references "YACTIVITIES"("REF");
alter table "UPXXXXXXXXX"."ZDISTRICTS" add constraint ZDISTRICTS_REGION_FK foreign key("REGION") references "ZREGIONS"("COD");
alter table "UPXXXXXXXXX"."ZMUNICIPALITIES" add constraint ZMUNICIPALITIES_REGION_FK foreign key("REGION") references "ZREGIONS"("COD");
alter table "UPXXXXXXXXX"."ZMUNICIPALITIES" add constraint ZMUNICIPALITIES_DISTRICT_FK foreign key("DISTRICT") references "ZDISTRICTS"("COD");
alter table "UPXXXXXXXXX"."ZFACILITIES" add constraint ZFACILITIES_MUNICIPALITY_FK foreign key("MUNICIPALITY") references "ZMUNICIPALITIES"("COD");
alter table "UPXXXXXXXXX"."ZFACILITIES" add constraint ZFACILITIES_ROOMTYPE_FK foreign key("ROOMTYPE") references "ZROOMTYPES"("ROOMTYPE");
alter table "UPXXXXXXXXX"."ZUSES" add constraint ZUSES_ID_FK foreign key("ID") references "ZFACILITIES"("ID");
alter table "UPXXXXXXXXX"."ZUSES" add constraint ZUSES_REF_FK foreign key("REF") references "ZACTIVITIES"("REF");