/* ===== BLOCK: Block 3 ===== */

/* ===== CODE: TLAUNCH_VEHICLE1 ===== */

create or replace table TLAUNCH_VEHICLE1 (
  LV_NAME varchar,
  CLASS varchar
  );

INSERT INTO TLAUNCH_VEHICLE1 (LV_NAME, CLASS)  
SELECT 
    "countLV_Name" AS LV_NAME,
    "Class" as CLASS 
FROM "Launch-vehicle-jonathan-lv";

/* ===== CODE: TLAUNCH_VEHICLE2 ===== */

create or replace table TLAUNCH_VEHICLE2 (
  LV_NAME varchar,
  PIECE_LS varchar
  );

INSERT INTO TLAUNCH_VEHICLE2 (LV_NAME,PIECE_LS)    
SELECT 
    "LV_Type" AS LV_NAME,
    "Piece" AS PIECE_LS
FROM "Launchlog-launchlog"
;
