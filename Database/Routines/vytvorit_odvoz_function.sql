/**
  Initializes new odvoz and if all criteria are met returns the id of new odvoz.
  With this returned we than call @procedure fill_odvoz that connects wanted produkt's.
 */
CREATE OR REPLACE FUNCTION vytvorit_odvoz(id_pobocka IN INTEGER)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    id_odvoz    INTEGER;
    offset_rest INTEGER := (1 + (RANDOM() * 10)::INT);
BEGIN
    -- check that the id is valid
    IF id_pobocka > (SELECT COUNT(*) FROM pobocka) OR id_pobocka < 1 THEN
        RETURN -1;
    END IF;

    -- Create new odvoz
    id_odvoz := NEXTVAL('odvoz_odvoz_id_seq');
    INSERT INTO odvoz (odvoz_id, pobocka_id, ridic_id, stav, datum_objednani, datum_prevzeti, datum_dovezeni)
    VALUES (id_odvoz, id_pobocka, NULL, 'objednan', CURRENT_DATE, NULL, NULL);

    -- Restauraceprodukty is secondary just to mask the meth so add some random amount.
    FOR i IN 1..(1 + (RANDOM() * 10)::INT)
        LOOP
            INSERT INTO restaurace_odvoz (odvoz_id, restauraceprodukty_id, mnozstvi)
            VALUES (id_odvoz, MOD(i + offset_rest, 19) + 1, 1 + (RANDOM() * 5000)::INT);
        END LOOP;

    RETURN id_odvoz;
END;
$$;