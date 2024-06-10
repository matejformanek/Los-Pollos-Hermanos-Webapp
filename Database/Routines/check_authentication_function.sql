/**
  Function that will be called in login with email and hashed password
  If the authentication is successful returns role_id of newly logged person.
 */
CREATE OR REPLACE FUNCTION check_authentication(email IN VARCHAR, psswd IN VARCHAR)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    id_role         INTEGER;
    hash_psswd      VARCHAR;
    konec_platnosti DATE;
BEGIN
    -- Checks that person exists and has active role
    SELECT role_id, heslo, COALESCE(do_datum, CURRENT_DATE + INTERVAL '1 year')
    INTO id_role,hash_psswd, konec_platnosti
    FROM zamestnanec
             JOIN public.role ON zamestnanec.zamestnanec_id = role.zamestnanec_id
    WHERE mail = email
    ORDER BY role_id DESC
    LIMIT 1;

    IF konec_platnosti < CURRENT_DATE THEN
        RETURN -1;
    END IF;

    IF psswd = hash_psswd THEN
        RETURN id_role;
    END IF;

    RETURN -1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN -1;
END;
$$;