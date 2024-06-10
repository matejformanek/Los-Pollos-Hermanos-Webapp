/**
  Drops all functions, triggers, procedures and views created in DB.
 */
DROP PROCEDURE IF EXISTS novavarka(NUMERIC, NUMERIC, VARCHAR, VARCHAR) CASCADE;

DROP TRIGGER IF EXISTS doplneni_surovin ON surovina;
DROP FUNCTION IF EXISTS doplnsuroviny() CASCADE;

DROP FUNCTION IF EXISTS check_authentication(email VARCHAR, psswd VARCHAR) CASCADE;

DROP FUNCTION IF EXISTS vytvorit_odvoz(id_pobocka INTEGER) CASCADE;
DROP PROCEDURE IF EXISTS fill_odvoz(id_odvoz INTEGER, id_produkt INTEGER, pocet_varek INTEGER) CASCADE;