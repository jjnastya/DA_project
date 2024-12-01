/* ===== BLOCK: Block 4 ===== */

/* ===== CODE: LAUNCH_VEHICLE_ALLT ===== */

CREATE OR REPLACE TABLE LAUNCH_VEHICLE_ALLT AS
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY LVT2.LV_NAME) AS ID_LAUNCHVEHICLE,
    LVT2.LV_NAME,
    LVT2.PIECE_LS,
    LVT1.CLASS
FROM 
    TLAUNCH_VEHICLE2 AS LVT2
LEFT JOIN 
    TLAUNCH_VEHICLE1 AS LVT1 ON LVT2.LV_NAME = LVT1.LV_NAME;

SELECT *
FROM LAUNCH_VEHICLE_ALLT;

ALTER TABLE LAUNCH_VEHICLE_ALLT ADD COLUMN ID_LAUNCHSITE NUMBER;

UPDATE LAUNCH_VEHICLE_ALLT AS LVAT
SET LVAT.ID_LAUNCHSITE = LSAT.ID_LAUNCHSITE
FROM LAUNCH_SITE_ALLT AS LSAT
WHERE LVAT.PIECE_LS = LSAT.PIECE_LS;

ALTER TABLE LAUNCH_VEHICLE_ALLT DROP COLUMN PIECE_LS;