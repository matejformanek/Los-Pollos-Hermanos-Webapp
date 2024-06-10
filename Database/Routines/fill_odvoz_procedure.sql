/**
  Procedure that fills the M:N bond between odvoz and produkt.
  When we create new odvoz, this will fill wanted produkt
 */
CREATE OR REPLACE PROCEDURE fill_odvoz(id_odvoz IN INTEGER, id_produkt IN INTEGER, pocet_varek IN INTEGER)
    LANGUAGE plpgsql
AS
$$
DECLARE
    dummy INTEGER;
BEGIN
    IF pocet_varek < 0 THEN
        RAISE EXCEPTION 'Pocet varek musi byt alespon 1';
    END IF;

    -- If we got 0 there is no reason to log that
    IF pocet_varek = 0 THEN
        RETURN;
    END IF;

    -- Check that the provided id's are correct
    SELECT odvoz.odvoz_id INTO dummy FROM odvoz WHERE odvoz_id = id_odvoz;
    IF dummy IS NULL THEN
        RAISE EXCEPTION 'invalid Odvoz ID';
    END IF;
    SELECT produkt_id INTO dummy FROM produkt WHERE produkt_id = id_produkt;
    IF dummy IS NULL THEN
        RAISE EXCEPTION 'invalid Produkt ID';
    END IF;

    INSERT INTO produkt_odvoz (odvoz_id, produkt_id, pocetvarek) VALUES (id_odvoz, id_produkt, pocet_varek);
END;
$$;