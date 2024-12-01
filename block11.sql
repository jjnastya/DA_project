/* ===== BLOCK: Block 11 ===== */

/* ===== CODE: SATELLITE2 ===== */

create or replace table SATELLITE2 (
    PURPOSE varchar,
    EXPECTED_LIFETIME varchar,
    ID_SATELLITE varchar
    );

insert into SATELLITE2 (PURPOSE, EXPECTED_LIFETIME, ID_SATELLITE)
SELECT "Purpose" AS PURPOSE,
        "Expected_Lifetime_yrs" AS EXPECTED_LIFETIME,
        "COSPAR_Number" AS ID_SATELLITE
FROM "UCS-Satellite-Database-5-1-2023-Sheet1";
