/**
  Trigger to simulate system that can automatically order new suroviny when they fall under some amount
  and creates log in database about order of new objednavka and naskladneni.
 */
CREATE OR REPLACE FUNCTION doplnsuroviny() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    id_objednavka INTEGER;
    id_skladnik   INTEGER;
BEGIN
    -- Pokud spadneme dolu automaticky vytvor special objednavku
    IF new.mnozstvi > 100000 THEN
        RETURN new;
    END IF;

    -- Doplni na plne zasoby
    UPDATE surovina SET mnozstvi = 1000000 WHERE surovina_id = new.surovina_id;

    -- Vytvori random objednavku
    id_objednavka := NEXTVAL('objednavka_objednavka_id_seq');
    INSERT INTO objednavka (objednavka_id, dodavatel_id, datum_objednani, datum_dodani, cena)
    VALUES (id_objednavka, 1 + (RANDOM() * 10)::INT, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE,
            50000.0 + (RANDOM() * (950000.0 - 50000.0)));

    -- Prida zaznam o mnozstvi
    INSERT INTO objednavka_surovina (objednavka_id, surovina_id, mnozstvi)
    VALUES (id_objednavka, new.surovina_id, 1000000 - new.mnozstvi);

    -- Skladnik ktery to naskladni
    SELECT skladnik_id
    INTO id_skladnik
    FROM skladnik
    ORDER BY RANDOM()
    LIMIT 1;
    INSERT INTO objednavka_skladnik (objednavka_id, skladnik_id) VALUES (id_objednavka, id_skladnik);

    RETURN new;
END;
$$;

/**
  Set trigger on surovina
 */
CREATE TRIGGER doplneni_surovin
    AFTER UPDATE OF mnozstvi
    ON surovina
    FOR EACH ROW
EXECUTE FUNCTION doplnsuroviny();