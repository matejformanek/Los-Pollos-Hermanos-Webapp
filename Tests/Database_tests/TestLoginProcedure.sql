DO
$$
    BEGIN
        IF -1 = check_authentication('test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08') THEN
            RAISE EXCEPTION 'Valid user not authenticated!';
        END IF;

        IF -1 <> check_authentication('test', 'test') THEN
            RAISE EXCEPTION 'Invalid authentication!';
        END IF;

        IF -1 <> check_authentication('', '') THEN
            RAISE EXCEPTION 'Invalid authentication!';
        END IF;

        IF -1 <> check_authentication('test', '') THEN
            RAISE EXCEPTION 'Invalid authentication!';
        END IF;

        IF -1 <> check_authentication('', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08') THEN
            RAISE EXCEPTION 'Invalid authentication!';
        END IF;

        IF -1 <> check_authentication('badger@example.com',
                                      '56b1db8133d9eb398aabd376f07bf8ab5fc584ea0b8bd6a1770200cb613ca005') THEN
            RAISE EXCEPTION 'Invalid authentication!';
        END IF;

        RAISE NOTICE 'Authentication tests successful.';
    END;
$$;