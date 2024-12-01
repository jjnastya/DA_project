/* ===== BLOCK: Block 5 ===== */

/* ===== CODE: LAUNCH_FINALT ===== */

create or replace table LAUNCH_FINALT (
  ID_LAUNCH number autoincrement start 1 increment 1,
  DATE_OF_LAUNCH varchar,
  TIME_OF_LAUNCH varchar,
  PIECE VARCHAR,
  ID_LAUNCHSITE NUMBER,
  SUCCESS_RATE VARCHAR
  )
  ;

INSERT INTO LAUNCH_FINALT ( DATE_OF_LAUNCH,TIME_OF_LAUNCH, PIECE,ID_LAUNCHSITE, SUCCESS_RATE)
SELECT
         left ("Launch_Date", 11) AS DATE_OF_LAUNCH 
        , CASE
            WHEN LENGTH("Launch_Date") = 11
                THEN NULL  -- No time component in this format
            WHEN LENGTH("Launch_Date") = 16
                THEN concat(left(right("Launch_Date", 4),2),':',left(right("Launch_Date", 2),2))

            WHEN LENGTH("Launch_Date") = 17
                THEN concat(left(right("Launch_Date", 5),2),':',left(right("Launch_Date", 3),2))
                
            WHEN LENGTH("Launch_Date") = 19
                THEN concat(left(right("Launch_Date", 7),2),':',left(right("Launch_Date", 5),2)) 

            WHEN LENGTH("Launch_Date") = 20
                THEN concat(left(right("Launch_Date", 8),2),':',left(right("Launch_Date", 6),2)) 
            ELSE null
            end AS TIME_OF_LAUNCH
        , "Piece" as PIECE
  , NULL AS ID_LAUNCHSITE
  , "Launch_Code" AS SUCCESS_RATE
    FROM "Launchlog-launchlog";

UPDATE LAUNCH_FINALT AS LFT
SET LFT.ID_LAUNCHSITE = LSAT.ID_LAUNCHSITE
FROM LAUNCH_SITE_ALLT AS LSAT
WHERE LFT.PIECE = LSAT.PIECE_LS;

UPDATE LAUNCH_FINALT
SET SUCCESS_RATE = SUBSTR(SUCCESS_RATE, 2, 1);
