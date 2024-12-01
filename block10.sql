/* ===== BLOCK: Block 10 ===== */

/* ===== CODE: SATELLITE1 ===== */

create or replace table SATELLITE1 (
  ID_SATELLITE varchar, 
  SATELLITE_NAME varchar,
  ALTERNATE_NAME varchar,
  ID_OWNER number,
  ID_LAUNCH number,
  AGENCY_NAME varchar,
  PRIMARY KEY (ID_SATELLITE, SATELLITE_NAME)
  );

INSERT INTO SATELLITE1 (ID_SATELLITE, 
                        SATELLITE_NAME, 
                        ALTERNATE_NAME,
                        AGENCY_NAME)
SELECT "Piece" AS ID_SATELLITE, 
        "Name" AS SATELLITE_NAME,
        "PLName" AS ALTERNATE_NAME,
        "Agency" as AGENCY_NAME
FROM "Launchlog-launchlog";
