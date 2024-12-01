/* ===== BLOCK: Block 9 ===== */

/* ===== CODE: PURPOSE,CLASS,ENDS ===== */

create or replace table PURPOSE (
  ID_SATELLITE varchar,
  PURPOSE varchar,
  CLASS varchar,
  END_OF_TRANSMISSION varchar,
  END_OF_OPERATION varchar
  );

INSERT INTO PURPOSE (ID_SATELLITE, PURPOSE, CLASS, END_OF_TRANSMISSION, END_OF_OPERATION)
SELECT "Piece" AS ID_SATELLITE,
"Category" AS PURPOSE,
"Class" AS CLASS,
"TDate" AS END_OF_TRANSMISSION,
"TOp" AS END_OF_OPERATION
FROM "payload-psatcat";
