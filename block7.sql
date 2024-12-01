/* ===== BLOCK: Block 7 ===== */

/* ===== CODE: AGENCY ===== */

create or replace table AGENCY (
  ID_AGENCY number autoincrement start 1 increment 1,
  AGENCY_NAME varchar
  );

INSERT INTO AGENCY (AGENCY_NAME)
SELECT DISTINCT "Agency" AS AGENCY_NAME
FROM "Launchlog-launchlog";

/* ===== CODE: AGENCY_2 ===== */

create or replace table AGENCY_2 (
  AGENCY_NAME_ALL varchar,
  AGENCY_COUNTRY_ALL varchar,
  AGENCY_FULL_NAME varchar
  );

INSERT INTO AGENCY_2 (AGENCY_COUNTRY_ALL, AGENCY_NAME_ALL, AGENCY_FULL_NAME)
SELECT "StateCode" AS AGENCY_COUNTRY_ALL,
"Code" AS AGENCY_NAME_ALL,
"Name" AS AGENCY_FULL_NAME
FROM "organizations-orgs--2-";
