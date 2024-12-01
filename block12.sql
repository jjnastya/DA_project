/* ===== BLOCK: Block 12 ===== */

/* ===== CODE: SATELLITE_ALL ===== */

create or replace table SATELLITE_ALL as
    select 
        S1.ID_SATELLITE, 
        S1.SATELLITE_NAME,
        S1.ALTERNATE_NAME,
        S1.AGENCY_NAME
    from SATELLITE1 as S1
        left join SATELLITE2 as S2
        on S1.ID_SATELLITE = S2.ID_SATELLITE;

ALTER TABLE SATELLITE_ALL
ADD PRIMARY KEY (ID_SATELLITE, SATELLITE_NAME);

--- přidáváme id_owner
ALTER TABLE SATELLITE_ALL
ADD COLUMN ID_OWNER INT;

UPDATE SATELLITE_ALL AS SA
SET SA.ID_OWNER = O.ID_OWNER
FROM OWNER AS O
WHERE SA.ID_SATELLITE = O.ID_SATELLITE;

--- přidáváme id_launch
ALTER TABLE SATELLITE_ALL
ADD COLUMN ID_LAUNCH INT;

UPDATE SATELLITE_ALL AS SA
SET SA.ID_LAUNCH = LF.ID_LAUNCH
FROM LAUNCH_FINALT AS LF
WHERE SA.ID_SATELLITE = LF.PIECE;

--- přidáváme id_agency
ALTER TABLE SATELLITE_ALL
ADD COLUMN ID_AGENCY INT;

UPDATE SATELLITE_ALL AS SA
SET SA.ID_AGENCY = AC.ID_AGENCY
FROM AGENCY_COMPLETE AS AC
WHERE SA.AGENCY_NAME = AC.AGENCY_NAME;

--- přidáváme PURPOSE
ALTER TABLE SATELLITE_ALL
ADD COLUMN PURPOSE varchar,
CLASS varchar,
END_OF_TRANSMISSION varchar,
END_OF_OPERATION varchar;

UPDATE SATELLITE_ALL AS SA
SET SA.PURPOSE = P.PURPOSE,
SA.CLASS = P.CLASS,
SA.END_OF_TRANSMISSION = P.END_OF_TRANSMISSION,
SA.END_OF_OPERATION = P.END_OF_OPERATION
FROM PURPOSE AS P
WHERE SA.ID_SATELLITE = P.ID_SATELLITE;

/* ===== CODE: REMOVE '?' ===== */

UPDATE SATELLITE_ALL 
    SET END_OF_TRANSMISSION = CASE
            WHEN LENGTH("END_OF_TRANSMISSION") = 16
                THEN left ("END_OF_TRANSMISSION", 11)

            WHEN LENGTH("END_OF_TRANSMISSION") = 5
                THEN left ("END_OF_TRANSMISSION", 4)
                
            WHEN LENGTH("END_OF_TRANSMISSION") = 9
                THEN left ("END_OF_TRANSMISSION", 8)

            WHEN LENGTH("END_OF_TRANSMISSION") = 12
                THEN left ("END_OF_TRANSMISSION", 11)

            WHEN LENGTH("END_OF_TRANSMISSION") = 17
                THEN left ("END_OF_TRANSMISSION", 11)

            WHEN LENGTH("END_OF_TRANSMISSION") = 6
                THEN left ("END_OF_TRANSMISSION", 4)

             WHEN LENGTH("END_OF_TRANSMISSION") = 8
                THEN left ("END_OF_TRANSMISSION", 4)

             WHEN LENGTH("END_OF_TRANSMISSION") = 11
                THEN left ("END_OF_TRANSMISSION", 10)

             WHEN LENGTH("END_OF_TRANSMISSION") = 20
                THEN left ("END_OF_TRANSMISSION", 11)

             WHEN LENGTH("END_OF_TRANSMISSION") = 13
                THEN left ("END_OF_TRANSMISSION", 12)

            WHEN LENGTH("END_OF_TRANSMISSION") = 7
                THEN left ("END_OF_TRANSMISSION", 4)

             WHEN LENGTH("END_OF_TRANSMISSION") >= 24
                THEN left ("END_OF_TRANSMISSION", 11)
            ELSE END_OF_TRANSMISSION
            end;

UPDATE SATELLITE_ALL 
    SET END_OF_OPERATION = CASE
            WHEN LENGTH("END_OF_OPERATION") = 16
                THEN left ("END_OF_OPERATION", 11)

            WHEN LENGTH("END_OF_OPERATION") = 5
                THEN left ("END_OF_OPERATION", 4)
                
            WHEN LENGTH("END_OF_OPERATION") = 9
                THEN left ("END_OF_OPERATION", 8)

            WHEN LENGTH("END_OF_OPERATION") = 12
                THEN left ("END_OF_OPERATION", 11)

            WHEN LENGTH("END_OF_OPERATION") = 17
                THEN left ("END_OF_OPERATION", 11)

            WHEN LENGTH("END_OF_OPERATION") = 6
                THEN left ("END_OF_OPERATION", 4)

             WHEN LENGTH("END_OF_OPERATION") = 8
                THEN left ("END_OF_OPERATION", 4)

             WHEN LENGTH("END_OF_OPERATION") = 11
                THEN left ("END_OF_OPERATION", 10)

             WHEN LENGTH("END_OF_OPERATION") = 20
                THEN left ("END_OF_OPERATION", 11)

             WHEN LENGTH("END_OF_OPERATION") = 13
                THEN left ("END_OF_OPERATION", 12)

             WHEN LENGTH("END_OF_OPERATION") = 7
                THEN left ("END_OF_OPERATION", 4)

            WHEN LENGTH("END_OF_OPERATION") >= 24
                THEN left ("END_OF_OPERATION", 11)
            ELSE END_OF_OPERATION
            end;

/* ===== CODE: STATUS COLUMN ===== */

--pridali sloupec status
ALTER TABLE SATELLITE_ALL ADD COLUMN STATUS VARCHAR(255);

--zkopirovali end of transmission do statusu

UPDATE SATELLITE_ALL
SET STATUS = END_OF_TRANSMISSION;

--zmenili hvezdicky na string ve statusu

UPDATE SATELLITE_ALL 
    SET STATUS = CASE
            WHEN LENGTH(STATUS) > 1
                THEN 'No longer transmitting'
            WHEN LENGTH(STATUS) = 1
                THEN 'Still transmitting'
            end;

/* ===== CODE: REPLACE "*" TO NULL ===== */

UPDATE SATELLITE_ALL 
    SET END_OF_TRANSMISSION = CASE
            WHEN LENGTH(END_OF_TRANSMISSION) = 1
                THEN NULL
            ELSE END_OF_TRANSMISSION
            end;

UPDATE SATELLITE_ALL 
    SET END_OF_OPERATION = CASE
            WHEN LENGTH(END_OF_OPERATION) = 1
                THEN NULL
            ELSE END_OF_OPERATION
            end;
