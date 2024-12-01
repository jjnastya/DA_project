/* ===== BLOCK: Block 1 ===== */

/* ===== CODE: LAUNCH_SITE_T1 ===== */

create or replace table LAUNCH_SITE_T1 (
  --ID_LAUNCHSITE number autoincrement start 1 increment 1,
  LS_NAME varchar,
  LS_FULLNAME VARCHAR,
  LS_COUNTRY varchar,
  LONGITUDE VARCHAR,
  LATITUDE VARCHAR
  );

INSERT INTO LAUNCH_SITE_T1 (LS_NAME, LS_COUNTRY, LS_FULLNAME, LONGITUDE, LATITUDE)
SELECT "countSite" AS LS_NAME,
       "StateCode" AS LS_COUNTRY,
       "Name" AS LS_FULLNAME,
       CASE WHEN "Longitude"='' OR "Longitude"='-'THEN NULL
   WHEN TRY_CAST("Longitude" AS FLOAT) IS NULL THEN NULL
  ELSE "Longitude" 
  END AS  LONGITUDE,
       CASE WHEN "Latitude"='' OR "Latitude"='-' THEN NULL 
   WHEN TRY_CAST("Latitude" AS FLOAT) IS NULL THEN NULL
  ELSE "Latitude" 
  END AS LATITUDE
FROM "Lauch-site-jonathan--sites";

/* ===== CODE: LAUNCH_SITE_T2 ===== */

create or replace table LAUNCH_SITE_T2 (
  ID_LAUNCHSITE number autoincrement start 1 increment 1,
  LS_NAME varchar,
  PIECE_LS varchar
  );

INSERT INTO LAUNCH_SITE_T2 (LS_NAME, PIECE_LS)
SELECT "Launch_Site" AS LS_NAME,
"Piece" AS PIECE_LS
FROM "Launchlog-launchlog";

