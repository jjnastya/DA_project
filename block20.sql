/* ===== BLOCK: Block 20 ===== */

/* ===== CODE: SATELLITE_ALL:PURPOSE, PURPOSE_NAME ===== */

UPDATE SATELLITE_ALL AS SA
SET PURPOSE = CNP.PURPOSE_FIX
FROM "CODE_NAME_PURPOSE-Sheet1" AS CNP
WHERE SA.PURPOSE = CNP.PURPOSE;

ALTER TABLE SATELLITE_ALL ADD COLUMN PURPOSE_NAME VARCHAR;

UPDATE "CODE_NAME_PURPOSE-Sheet1" AS CNP
SET PURPOSE_NAME = CNP1.PURPOSE_NAME
FROM "CODE_NAME_PURPOSE-Sheet1" AS CNP1
WHERE CNP.PURPOSE_FIX = CNP1.PURPOSE_FIX
  AND CNP.PURPOSE_NAME IS NULL
  AND CNP1.PURPOSE_NAME IS NOT NULL;

UPDATE SATELLITE_ALL AS SA
SET PURPOSE_NAME = CNP.PURPOSE_NAME
FROM "CODE_NAME_PURPOSE-Sheet1" AS CNP
WHERE SA.PURPOSE = CNP.PURPOSE_FIX;
