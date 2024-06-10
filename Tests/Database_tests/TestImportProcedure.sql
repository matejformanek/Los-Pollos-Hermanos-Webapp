BEGIN;
DO
$$
    DECLARE
        odvoz_id INTEGER;
        hold1    INTEGER;
    BEGIN
        IF vytvorit_odvoz(-1) <> -1 THEN
            RAISE EXCEPTION USING MESSAGE = 'Invalid pobocka_id not detected!',ERRCODE = 'P0002';
        END IF;

        IF vytvorit_odvoz(55210) <> -1 THEN
            RAISE EXCEPTION USING MESSAGE = 'Invalid pobocka_id not detected!',ERRCODE = 'P0002';
        END IF;

        SELECT vytvorit_odvoz(1) INTO odvoz_id;
        IF odvoz_id = -1 THEN
            RAISE EXCEPTION USING MESSAGE = 'Valid odvoz should have been created!',ERRCODE = 'P0002';
        END IF;

        BEGIN
            CALL fill_odvoz(odvoz_id, 1, -1);

            RAISE EXCEPTION USING MESSAGE = 'Negative pocet_varek not detected!',ERRCODE = 'P0002';
        EXCEPTION
            WHEN SQLSTATE 'P0001' THEN
                NULL;
        END;

        BEGIN
            CALL fill_odvoz(-1, 1, -1);

            RAISE EXCEPTION USING MESSAGE = 'Invalid odvoz ID not detected!',ERRCODE = 'P0002';
        EXCEPTION
            WHEN SQLSTATE 'P0001' THEN
                NULL;
        END;

        BEGIN
            CALL fill_odvoz(odvoz_id, -1, -1);

            RAISE EXCEPTION USING MESSAGE = 'Invalid produkt ID not detected!',ERRCODE = 'P0002';
        EXCEPTION
            WHEN SQLSTATE 'P0001' THEN
                NULL;
        END;

        CALL fill_odvoz(odvoz_id, 1, 1);

        SELECT COUNT(*) INTO hold1 FROM produkt_odvoz;

        CALL fill_odvoz(odvoz_id, 1, 0);

        IF hold1 <> (SELECT COUNT(*) FROM produkt_odvoz) THEN
            RAISE EXCEPTION USING MESSAGE = 'pocet_varek = 0 added to produkt_odvoz!',ERRCODE = 'P0002';
        END IF;
        RAISE NOTICE 'New import tests successful.';
    EXCEPTION
        WHEN SQLSTATE 'P0001' THEN
            RAISE EXCEPTION 'Error inserting valid produkt_odvoz!';
    END;
$$;
ROLLBACK;