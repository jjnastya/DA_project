/* ===== BLOCK: Block 6 ===== */

/* ===== CODE: OWNER ===== */

create or replace table OWNER (
  ID_OWNER number autoincrement start 1 increment 1,
  OWNER_NAME varchar,
  OWNER_COUNTRY varchar,
  ID_SATELLITE varchar
  );

INSERT INTO OWNER (OWNER_NAME, OWNER_COUNTRY, ID_SATELLITE)
        SELECT "SatOwner" AS OWNER_NAME
        , "SatState" AS OWNER_COUNTRY
        , "Piece" AS SATELLITE_ID
    FROM "Launchlog-launchlog";
