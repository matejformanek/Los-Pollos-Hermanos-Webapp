BEGIN;
DO
$$
    BEGIN
        CALL novavarka(100, 50, 'walter.white@example.com');
        BEGIN
            BEGIN
                BEGIN
                    BEGIN
                        CALL novavarka(0, 0, 'test');
                        RAISE EXCEPTION USING MESSAGE = 'Invalid kuchar name was not detected!',ERRCODE = 'P0002';
                    EXCEPTION
                        WHEN SQLSTATE 'P0001' THEN
                            CALL novavarka(-1, 0, 'walter.white@example.com');
                            RAISE EXCEPTION USING MESSAGE = 'Invalid mnozstvi not detected!',ERRCODE = 'P0002';
                    END;
                EXCEPTION
                    WHEN SQLSTATE 'P0001' THEN
                        CALL novavarka(5, -1, 'walter.white@example.com');
                        RAISE EXCEPTION USING MESSAGE = 'Invalid cistota (negative) not detected!',ERRCODE = 'P0002';
                END;
            EXCEPTION
                WHEN SQLSTATE 'P0001' THEN
                    CALL novavarka(5, 101, 'walter.white@example.com');
                    RAISE EXCEPTION USING MESSAGE = 'Invalid cistota (over 100) not detected!',ERRCODE = 'P0002';
            END;
        EXCEPTION
            WHEN SQLSTATE 'P0001' THEN
                RAISE NOTICE 'New batch tests successful.';
        END;
    EXCEPTION
        WHEN SQLSTATE 'P0001' THEN
            RAISE EXCEPTION 'New batch should have been created!';
    END;
$$;
ROLLBACK;