/* ===== BLOCK: Block 8 ===== */

/* ===== CODE: AGENCY_COMPLETE ===== */

create or replace table AGENCY_COMPLETE as
    select 
        A1.ID_AGENCY, 
        A1.AGENCY_NAME,
        A2.AGENCY_COUNTRY_ALL AS AGENCY_COUNTRY,
        A2.AGENCY_FULL_NAME
    from AGENCY as A1
        left join AGENCY_2 as A2
        on A1.AGENCY_NAME = A2.AGENCY_NAME_ALL;

update agency_complete
    set
        agency_country = case 
            when agency_country is null then 'international'
            else agency_country 
        end,
        agency_full_name = case 
            when agency_full_name is null then agency_name
            else agency_full_name
        end;
