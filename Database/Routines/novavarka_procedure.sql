/**
  Creates new varka when kuchar's finished theire cooking.
 */
CREATE OR REPLACE PROCEDURE novavarka(uvareno_mnozstvi IN NUMERIC, cistota IN NUMERIC, kuchar1 IN VARCHAR,
                                      kuchar2 IN VARCHAR DEFAULT NULL)
    LANGUAGE plpgsql
AS
$$
DECLARE
    id_varka   INTEGER;
    id_produkt INTEGER;
    id_kuchar1 INTEGER;
    id_kuchar2 INTEGER;
    rada       RECORD;
BEGIN
    -- Check edge cases of invalid values
    IF cistota < 0 OR cistota > 100 THEN
        RAISE EXCEPTION 'Nevalidni kvalita varky';
    ELSIF
        uvareno_mnozstvi < 0 THEN
        RAISE EXCEPTION 'Nevalidni mnozstvi uvarene varky';
    END IF;

    id_varka := NEXTVAL('vareni_vareni_id_seq');

    -- Insert vareni
    INSERT INTO vareni (vareni_id, datum) VALUES (id_varka, CURRENT_DATE);

    -- Insert varka
    SELECT produkt_id
    INTO id_produkt
    FROM produkt
    WHERE procentocistotymin <= cistota AND procentocistotymax >= cistota;
    INSERT INTO varka (varka_id, produkt_id, odvoz_id, pobocka_id, prodej_id, kvalita, mnozstvi_uvareno, stav)
    VALUES (id_varka, id_produkt, NULL, NULL, NULL, cistota, uvareno_mnozstvi, 'uvareno');

    -- Insert kuchar
    SELECT kuchar_id
    INTO STRICT id_kuchar1
    FROM kuchar
             JOIN public.role ON role.role_id = kuchar.kuchar_id
             JOIN public.zamestnanec ON zamestnanec.zamestnanec_id = role.zamestnanec_id
    WHERE mail = kuchar1;
    INSERT INTO vareni_kuchar (kuchar_id, vareni_id) VALUES (id_kuchar1, id_varka);
    IF kuchar2 IS NOT NULL THEN
        SELECT kuchar_id
        INTO STRICT id_kuchar2
        FROM kuchar
                 JOIN public.role ON role.role_id = kuchar.kuchar_id
                 JOIN public.zamestnanec ON zamestnanec.zamestnanec_id = role.zamestnanec_id
        WHERE mail = kuchar2;
        INSERT INTO vareni_kuchar (kuchar_id, vareni_id) VALUES (id_kuchar2, id_varka);
    END IF;

    -- Insert surovina_vareni (simulates that we have the recipe for how to cook)
    FOR rada IN (SELECT *
                 FROM surovina
                 ORDER BY mnozstvi DESC
                 LIMIT 10)
        LOOP
            INSERT INTO surovina_vareni (vareni_id, surovina_id, mnozstvi)
            VALUES (id_varka, rada.surovina_id, uvareno_mnozstvi / 10);
            UPDATE surovina SET mnozstvi = mnozstvi - uvareno_mnozstvi / 10 WHERE surovina_id = rada.surovina_id;
        END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'Neexistujici jmeno kuchare';
END;
$$;