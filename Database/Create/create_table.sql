/* Create Tables */

-- Sklad
CREATE TABLE adresa
(
    adresa_id    SERIAL      NOT NULL,
    dodavatel_id INTEGER     NULL,
    pobocka_id   INTEGER     NULL,
    stat         VARCHAR(50) NOT NULL, -- Stát nebo země
    mesto        VARCHAR(50) NULL,     -- Město ve kterém žije
    psc          VARCHAR(50) NULL,     -- Poštovní směrovací číslo
    ulice        VARCHAR(50) NULL      -- Ulice kde žije
);

CREATE TABLE dodavatel
(
    dodavatel_id SERIAL      NOT NULL,
    jmeno_firmy  VARCHAR(50) NULL -- Jméno firmy od které kupujeme suroviny na tvorbu pervitinu.
);

CREATE TABLE kuchar
(
    kuchar_id  INTEGER NOT NULL,
    roky_praxe INTEGER NULL -- Roky praxe v pozici kuchaře.
);

CREATE TABLE objednavka
(
    objednavka_id   SERIAL         NOT NULL,
    dodavatel_id    INTEGER        NOT NULL,
    datum_objednani DATE           NULL, -- Datum dne kdy jsme objednali suroviny.
    datum_dodani    DATE           NULL, -- Datum kdy přijela/přijede objednávka na sklad.
    cena            NUMERIC(10, 2) NULL  -- Celková cena nákupu surovin.
);

CREATE TABLE objednavka_skladnik
(
    objednavka_id INTEGER NOT NULL,
    skladnik_id   INTEGER NOT NULL
);

CREATE TABLE objednavka_surovina
(
    objednavka_id INTEGER        NOT NULL,
    surovina_id   INTEGER        NOT NULL,
    mnozstvi      NUMERIC(10, 2) NOT NULL -- Objednané množství které bude/bylo dodáno
);

CREATE TABLE produkt
(
    produkt_id         INTEGER     NOT NULL,
    cena               INTEGER     NOT NULL, -- Cena za 1 gram daného produktu.
    nazev              VARCHAR(50) NOT NULL, -- Prodejní název produktu.
    procentocistotymin INTEGER     NOT NULL, -- Rozmezí kvality pervitinu podle čistoty jeho krystalů.
    procentocistotymax INTEGER     NOT NULL
);

CREATE TABLE role
(
    role_id        SERIAL  NOT NULL,
    zamestnanec_id INTEGER NOT NULL,
    od_datum       DATE    NULL, -- Datum od kdy platí smlouva pro výkon práce v dané roly.
    do_datum       DATE    NULL  -- Datum do kdy platí smlouva pro výkon práce v dané roly.
);

CREATE TABLE pristupovaprava
(
    pristupovaprava_id SERIAL      NOT NULL,
    nazev              VARCHAR(50) NOT NULL -- název pozice
);

CREATE TABLE role_pristupovaprava
(
    role_id            INTEGER NOT NULL,
    pristupovaprava_id INTEGER NOT NULL
);

CREATE TABLE skladnik
(
    skladnik_id INTEGER     NOT NULL,
    certifikat  VARCHAR(50) NULL -- Certifikát na práci se stroji.
);

CREATE TABLE skladnik_odvoz
(
    skladnik_id INTEGER NOT NULL,
    odvoz_id    INTEGER NOT NULL
);

CREATE TABLE surovina
(
    surovina_id SERIAL         NOT NULL,
    nazev       VARCHAR(50)    NOT NULL, -- Obchodní název suroviny.
    mnozstvi    NUMERIC(10, 2) NOT NULL  -- Aktuální množství dané suroviny na skladě.
);

CREATE TABLE surovina_vareni
(
    vareni_id   INTEGER        NOT NULL,
    surovina_id INTEGER        NOT NULL,
    mnozstvi    NUMERIC(10, 2) NOT NULL -- Množství suroviny potřebné na uvaření dané várky.
);

CREATE TABLE vareni
(
    vareni_id SERIAL NOT NULL,
    datum     DATE   NOT NULL -- Datum dne kdy probíhálo vaření.
);

CREATE TABLE vareni_kuchar
(
    kuchar_id INTEGER NOT NULL,
    vareni_id INTEGER NOT NULL
);

CREATE TABLE vareni_skladnik
(
    vareni_id   INTEGER NOT NULL,
    skladnik_id INTEGER NOT NULL
);

CREATE TABLE varka
(
    varka_id         INTEGER        NOT NULL,
    produkt_id       INTEGER        NOT NULL,
    odvoz_id         INTEGER        NULL,
    pobocka_id       INTEGER        NULL,
    prodej_id        INTEGER        NULL,
    kvalita          NUMERIC(5, 2)  NOT NULL, -- Aktuální kvalita dané várky.
    mnozstvi_uvareno NUMERIC(10, 2) NOT NULL, -- Celkové množství kolik v dané várce bylo vyrobeno.
    stav             VARCHAR(50)    NOT NULL  -- Stav várky, zda je naskladě či již odvezena a pouze jako historie.
);

CREATE TABLE zamestnanec
(
    zamestnanec_id SERIAL       NOT NULL,
    adresa_id      INTEGER      NOT NULL,
    mail           VARCHAR(128) NOT NULL,
    heslo          VARCHAR(512) NOT NULL,
    datum_narozeni DATE         NULL, -- Datum narození
    jmeno          VARCHAR(50)  NULL, -- Jméno
    prijmeni       VARCHAR(50)  NULL  -- Příjmení
);

-- Distribuce
CREATE TABLE dealer
(
    dealer_id  INTEGER     NOT NULL,
    pobocka_id INTEGER     NOT NULL,
    teritorium VARCHAR(50) NULL -- Oblast na které prodává své zboží.
);

CREATE TABLE odvoz
(
    odvoz_id        SERIAL      NOT NULL,
    pobocka_id      INTEGER     NOT NULL,
    ridic_id        INTEGER     NULL,
    stav            VARCHAR(50) NOT NULL, -- Stav ve kterém se nachází odvoz.
    datum_objednani DATE        NOT NULL, -- Datum objednání
    datum_prevzeti  DATE        NULL,     -- Datum kdy si musí řidič převzít odvážku.
    datum_dovezeni  DATE        NULL      -- Datum dovezení
);

CREATE TABLE pobocka
(
    pobocka_id SERIAL      NOT NULL,
    nazev      VARCHAR(50) NULL -- Pracovní název pobočky

);

CREATE TABLE prodej
(
    prodej_id SERIAL         NOT NULL,
    dealer_id INTEGER        NOT NULL,
    ztraceno  NUMERIC(10, 2) NOT NULL,
    datum     DATE           NULL -- Datum kdy prodej proběhl.
);

CREATE TABLE restauraceprodukty
(
    restauraceprodukty_id SERIAL      NOT NULL,
    nazev                 VARCHAR(50) NOT NULL, -- Prodejní název produktu.
    cena                  INTEGER     NULL      -- Cena za jednu porci produktu.
);

CREATE TABLE pobocka_restaurace
(
    pobocka_id            INTEGER NOT NULL,
    restauraceprodukty_id INTEGER NOT NULL,
    mnozstvi              INTEGER NOT NULL -- množství daného restauračního produktu.
);

CREATE TABLE restaurace_odvoz
(
    odvoz_id              INTEGER NOT NULL,
    restauraceprodukty_id INTEGER NOT NULL,
    mnozstvi              INTEGER NOT NULL -- Množství kupovaného produktu.
);

CREATE TABLE produkt_odvoz
(
    odvoz_id   INTEGER NOT NULL,
    produkt_id INTEGER NOT NULL,
    pocetvarek INTEGER NOT NULL
);

CREATE TABLE ridic
(
    ridic_id  INTEGER        NOT NULL,
    maxnaklad NUMERIC(10, 2) NULL -- Velikost nákladního prostoru auta.
);

/* Create Primary Keys, Indexes, Uniques, Checks */

-- Sklad
ALTER TABLE adresa
    ADD CONSTRAINT pk_adresa
        PRIMARY KEY (adresa_id);

ALTER TABLE dodavatel
    ADD CONSTRAINT pk_dodavatel
        PRIMARY KEY (dodavatel_id);

CREATE INDEX ipkx_dodavatel ON dodavatel (dodavatel_id ASC);

ALTER TABLE pristupovaprava
    ADD CONSTRAINT pk_pristupovaprava
        PRIMARY KEY (pristupovaprava_id);

ALTER TABLE kuchar
    ADD CONSTRAINT pk_kuchar
        PRIMARY KEY (kuchar_id);

ALTER TABLE objednavka
    ADD CONSTRAINT pk_objednavka
        PRIMARY KEY (objednavka_id);

CREATE INDEX ipkx_objednavka ON objednavka (objednavka_id ASC);

ALTER TABLE objednavka_skladnik
    ADD CONSTRAINT pk_objednavka_skladnik
        PRIMARY KEY (skladnik_id, objednavka_id);

ALTER TABLE objednavka_surovina
    ADD CONSTRAINT pk_obsahuje
        PRIMARY KEY (objednavka_id, surovina_id);

CREATE INDEX ipkx_objednavka_surovina ON objednavka_surovina (objednavka_id ASC, surovina_id ASC);

ALTER TABLE produkt
    ADD CONSTRAINT pk_produkt
        PRIMARY KEY (produkt_id);

ALTER TABLE role
    ADD CONSTRAINT pk_role
        PRIMARY KEY (role_id);

ALTER TABLE role_pristupovaprava
    ADD CONSTRAINT pk_role_pristupovaprava
        PRIMARY KEY (role_id, pristupovaprava_id);

ALTER TABLE skladnik
    ADD CONSTRAINT pk_skladnik
        PRIMARY KEY (skladnik_id);

ALTER TABLE skladnik_odvoz
    ADD CONSTRAINT pk_nalozi
        PRIMARY KEY (skladnik_id, odvoz_id);

CREATE INDEX ixfk_nalozi_odvoz ON skladnik_odvoz (odvoz_id ASC);

ALTER TABLE surovina
    ADD CONSTRAINT pk_surovina
        PRIMARY KEY (surovina_id);

ALTER TABLE surovina_vareni
    ADD CONSTRAINT pk_pomersuroviny
        PRIMARY KEY (vareni_id, surovina_id);

ALTER TABLE vareni
    ADD CONSTRAINT pk_vareni
        PRIMARY KEY (vareni_id);

ALTER TABLE vareni_kuchar
    ADD CONSTRAINT pk_provadi
        PRIMARY KEY (vareni_id, kuchar_id);

ALTER TABLE vareni_skladnik
    ADD CONSTRAINT pk_vareni_skladnik
        PRIMARY KEY (vareni_id, skladnik_id);

ALTER TABLE varka
    ADD CONSTRAINT pk_varka
        PRIMARY KEY (varka_id);

CREATE INDEX ipkx_varka ON varka (varka_id ASC);

ALTER TABLE zamestnanec
    ADD CONSTRAINT pk_zamestnanec
        PRIMARY KEY (zamestnanec_id);

CREATE INDEX ipkx_zamestnanec ON zamestnanec (zamestnanec_id ASC);

-- Distribuce
ALTER TABLE dealer
    ADD CONSTRAINT pk_dealer
        PRIMARY KEY (dealer_id);

ALTER TABLE odvoz
    ADD CONSTRAINT pk_odvoz
        PRIMARY KEY (odvoz_id);

CREATE INDEX ipkx_odvoz ON odvoz (odvoz_id ASC);

ALTER TABLE pobocka
    ADD CONSTRAINT pk_pobocka
        PRIMARY KEY (pobocka_id);

ALTER TABLE pobocka_restaurace
    ADD CONSTRAINT pk_pobocka_restaurace
        PRIMARY KEY (restauraceprodukty_id, pobocka_id);

CREATE INDEX ixfk_pobocka_restaurace_ma ON pobocka_restaurace (pobocka_id ASC);

ALTER TABLE prodej
    ADD CONSTRAINT pk_prodej
        PRIMARY KEY (prodej_id);

CREATE INDEX ifkx_prodej ON prodej (dealer_id ASC);

ALTER TABLE restaurace_odvoz
    ADD CONSTRAINT pk_restaurace_odvoz
        PRIMARY KEY (odvoz_id, restauraceprodukty_id);

CREATE INDEX ipkx_restaurace_odvoz ON restaurace_odvoz (restauraceprodukty_id ASC, odvoz_id ASC);

ALTER TABLE produkt_odvoz
    ADD CONSTRAINT pk_produkt_odvoz
        PRIMARY KEY (odvoz_id, produkt_id);

CREATE INDEX ipkx_produkt_odvoz ON produkt_odvoz (produkt_id ASC, odvoz_id ASC);

ALTER TABLE restauraceprodukty
    ADD CONSTRAINT pk_restauraceprodukty
        PRIMARY KEY (restauraceprodukty_id);

ALTER TABLE ridic
    ADD CONSTRAINT pk_ridic
        PRIMARY KEY (ridic_id);

/* Create Foreign Key Constraints */

-- Sklad
ALTER TABLE adresa
    ADD CONSTRAINT fk_adresa_sidli_na
        FOREIGN KEY (dodavatel_id) REFERENCES dodavatel (dodavatel_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE kuchar
    ADD CONSTRAINT fk_kuchar_role
        FOREIGN KEY (kuchar_id) REFERENCES role (role_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE objednavka
    ADD CONSTRAINT fk_objednavka_surovina
        FOREIGN KEY (dodavatel_id) REFERENCES dodavatel (dodavatel_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE objednavka_skladnik
    ADD CONSTRAINT fk_naskladni_objednavka
        FOREIGN KEY (objednavka_id) REFERENCES objednavka (objednavka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE objednavka_skladnik
    ADD CONSTRAINT fk_naskladni_skladnik
        FOREIGN KEY (skladnik_id) REFERENCES skladnik (skladnik_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE role_pristupovaprava
    ADD CONSTRAINT fk_prava_role
        FOREIGN KEY (role_id) REFERENCES role (role_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE role_pristupovaprava
    ADD CONSTRAINT fk_prava_pristupova
        FOREIGN KEY (pristupovaprava_id) REFERENCES pristupovaprava (pristupovaprava_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE objednavka_surovina
    ADD CONSTRAINT fk_obsahuje_surovina
        FOREIGN KEY (surovina_id) REFERENCES surovina (surovina_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE objednavka_surovina
    ADD CONSTRAINT fk_obsahuje_objednavka
        FOREIGN KEY (objednavka_id) REFERENCES objednavka (objednavka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE role
    ADD CONSTRAINT fk_role_ma_roli
        FOREIGN KEY (zamestnanec_id) REFERENCES zamestnanec (zamestnanec_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE skladnik
    ADD CONSTRAINT fk_skladnik_role
        FOREIGN KEY (skladnik_id) REFERENCES role (role_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE skladnik_odvoz
    ADD CONSTRAINT fk_nalozi_skladnik
        FOREIGN KEY (skladnik_id) REFERENCES skladnik (skladnik_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE skladnik_odvoz
    ADD CONSTRAINT fk_nalozi_odvoz
        FOREIGN KEY (odvoz_id) REFERENCES odvoz (odvoz_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE surovina_vareni
    ADD CONSTRAINT fk_pomer_suroviny_pouzilo
        FOREIGN KEY (vareni_id) REFERENCES vareni (vareni_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE surovina_vareni
    ADD CONSTRAINT fk_pomer_suroviny_je_typu
        FOREIGN KEY (surovina_id) REFERENCES surovina (surovina_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE vareni_kuchar
    ADD CONSTRAINT fk_provadi_kuchar
        FOREIGN KEY (kuchar_id) REFERENCES kuchar (kuchar_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE vareni_kuchar
    ADD CONSTRAINT fk_provadi_vareni
        FOREIGN KEY (vareni_id) REFERENCES vareni (vareni_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE vareni_skladnik
    ADD CONSTRAINT fk_naskladni_vareni
        FOREIGN KEY (vareni_id) REFERENCES vareni (vareni_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE vareni_skladnik
    ADD CONSTRAINT fk_naskladni_skladnik
        FOREIGN KEY (skladnik_id) REFERENCES skladnik (skladnik_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE varka
    ADD CONSTRAINT fk_varka_je_typu
        FOREIGN KEY (produkt_id) REFERENCES produkt (produkt_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE varka
    ADD CONSTRAINT fk_varka_vytvorilo
        FOREIGN KEY (varka_id) REFERENCES vareni (vareni_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE varka
    ADD CONSTRAINT fk_varka_odvoz
        FOREIGN KEY (odvoz_id) REFERENCES odvoz (odvoz_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE varka
    ADD CONSTRAINT fk_varka_ma_naskladneno
        FOREIGN KEY (pobocka_id) REFERENCES pobocka (pobocka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE varka
    ADD CONSTRAINT fk_varka_obsahuje
        FOREIGN KEY (prodej_id) REFERENCES prodej (prodej_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE zamestnanec
    ADD CONSTRAINT fk_zamestnanec_bydli_na
        FOREIGN KEY (adresa_id) REFERENCES adresa (adresa_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Distribuce
ALTER TABLE dealer
    ADD CONSTRAINT fk_dealer_pracuje
        FOREIGN KEY (pobocka_id) REFERENCES pobocka (pobocka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dealer
    ADD CONSTRAINT fk_dealer_role
        FOREIGN KEY (dealer_id) REFERENCES role (role_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE odvoz
    ADD CONSTRAINT fk_odvoz_objednala
        FOREIGN KEY (pobocka_id) REFERENCES pobocka (pobocka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE odvoz
    ADD CONSTRAINT fk_odvoz_odvezl
        FOREIGN KEY (ridic_id) REFERENCES ridic (ridic_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE pobocka_restaurace
    ADD CONSTRAINT fk_pobocka_restaurace_je_typu
        FOREIGN KEY (restauraceprodukty_id) REFERENCES restauraceprodukty (restauraceprodukty_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE pobocka_restaurace
    ADD CONSTRAINT fk_pobocka_restaurace_ma
        FOREIGN KEY (pobocka_id) REFERENCES pobocka (pobocka_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE prodej
    ADD CONSTRAINT fk_prodej_provedl
        FOREIGN KEY (dealer_id) REFERENCES dealer (dealer_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE restaurace_odvoz
    ADD CONSTRAINT fk_obsahuje_produkty_do_restaurace
        FOREIGN KEY (restauraceprodukty_id) REFERENCES restauraceprodukty (restauraceprodukty_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE restaurace_odvoz
    ADD CONSTRAINT fk_obsahuje_odvoz
        FOREIGN KEY (odvoz_id) REFERENCES odvoz (odvoz_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE produkt_odvoz
    ADD CONSTRAINT fk_chce_produkt
        FOREIGN KEY (produkt_id) REFERENCES produkt (produkt_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE produkt_odvoz
    ADD CONSTRAINT fk_chce_odvoz
        FOREIGN KEY (odvoz_id) REFERENCES odvoz (odvoz_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE ridic
    ADD CONSTRAINT fk_ridic_role
        FOREIGN KEY (ridic_id) REFERENCES role (role_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

/* Create Table Comments, Sequences for Autonumber Columns */

-- Sklad
COMMENT ON TABLE adresa
    IS 'Adresa na které žijí zaměstnanci firmy či kde se nachází danná pobočka.';

COMMENT ON COLUMN adresa.mesto
    IS 'Město ve kterém žije';

COMMENT ON COLUMN adresa.psc
    IS 'Poštovní směrovací číslo';

COMMENT ON COLUMN adresa.stat
    IS 'Stát nebo země ';

COMMENT ON COLUMN adresa.ulice
    IS 'Ulice kde žije';

COMMENT ON TABLE dodavatel
    IS 'Firma která nám dodádává suroviny na tvorbu pervitinu.';

COMMENT ON COLUMN dodavatel.jmeno_firmy
    IS 'Jméno firmy od které kupujeme suroviny na tvorbu pervitinu.';

COMMENT ON TABLE kuchar
    IS 'Zděděná role zaměstnance který vaří pervitin.';

COMMENT ON COLUMN kuchar.roky_praxe
    IS 'Roky praxe v pozici kuchaře.';

COMMENT ON TABLE objednavka
    IS 'Objednávka surovin od dodavatele, při dodání ji musí naskladnit skladník.';

COMMENT ON COLUMN objednavka.cena
    IS 'Celková cena nákupu surovin.';

COMMENT ON COLUMN objednavka.datum_dodani
    IS 'Datum kdy přijela/přijede objednávka na sklad.';

COMMENT ON COLUMN objednavka.datum_objednani
    IS 'Datum dne kdy jsme objednali suroviny.';

COMMENT ON COLUMN objednavka_surovina.mnozstvi
    IS 'Objednané množství které bude/bylo dodáno';

COMMENT ON TABLE produkt
    IS 'Typy pervitinu, které prodáváme.';

COMMENT ON COLUMN produkt.cena
    IS 'Cena za 1 gram daného produktu.';

COMMENT ON COLUMN produkt.nazev
    IS 'Prodejní název produktu.';

COMMENT ON COLUMN produkt.procentocistotymin
    IS 'Rozmezí kvality pervitinu podle čistoty jeho krystalů.';

COMMENT ON TABLE role
    IS 'Nadtřída ze které dědí zaměstnanci firmy.';

COMMENT ON COLUMN role.do_datum
    IS 'Datum do kdy platí smlouva pro výkon práce v dané roly.';

COMMENT ON COLUMN role.od_datum
    IS 'Datum od kdy platí smlouva pro výkon práce v dané roly.';

COMMENT ON TABLE skladnik
    IS 'Zděděná role zaměstnance který naskladňuje suroviny či produkty a když prijde zásilka na odvoz tak nakládá řidiči vozidlo.';

COMMENT ON COLUMN skladnik.certifikat
    IS 'Hodnocení skladníka dle jeho výsledků vpráci.';

COMMENT ON TABLE surovina
    IS 'Chemikálie a jiné suroviny ze kterých se vaří pervitin.';

COMMENT ON COLUMN surovina.mnozstvi
    IS 'Aktuální množství dané suroviny na skladě.';

COMMENT ON COLUMN surovina.nazev
    IS 'Obchodní název suroviny.';

COMMENT ON COLUMN surovina_vareni.mnozstvi
    IS 'Množství suroviny potřebné na uvaření dané várky.';

COMMENT ON TABLE vareni
    IS 'Proces kdy bereme suroviny přetváříme na produkt a pokud se zadaří tak necháváme skladníka je přesunout k ostatním produktům.';

COMMENT ON COLUMN vareni.datum
    IS 'Datum dne kdy probíhálo vaření.';

COMMENT ON TABLE varka
    IS 'Výsledek vaření, jedná se o množství daného produktu který se jako celek (balíček) posílá dál na pobočky.';

COMMENT ON COLUMN varka.kvalita
    IS 'Aktuální kvalita dané várky.';

COMMENT ON COLUMN varka.mnozstvi_uvareno
    IS 'Celkové množství kolik v dané várce bylo vyrobeno.';

COMMENT ON COLUMN varka.stav
    IS 'Stav várky, zda je naskladě či již odvezena a pouze jako historie.';

COMMENT ON TABLE zamestnanec
    IS 'Pracovní síla v našem řetězci. Zaměřujeme se pouze na lidi pracující s pervitinem.';

COMMENT ON COLUMN zamestnanec.datum_narozeni
    IS 'Datum narození';

COMMENT ON COLUMN zamestnanec.jmeno
    IS 'Jméno';

COMMENT ON COLUMN zamestnanec.prijmeni
    IS 'Příjmení';

-- Distribuce
COMMENT ON TABLE dealer
    IS 'Role která se stará o přeprodej pervitinu, který přebírá na pobočce.';

COMMENT ON COLUMN dealer.teritorium
    IS 'Oblast na které prodává své zboží.';

COMMENT ON TABLE odvoz
    IS 'Objednávka podaná pobočkou aby jí z centrálního skladu dovezli pervitin.';

COMMENT ON COLUMN odvoz.datum_dovezeni
    IS 'Datum dovezení';

COMMENT ON COLUMN odvoz.datum_objednani
    IS 'Datum objednání';

COMMENT ON COLUMN odvoz.datum_prevzeti
    IS 'Datum kdy si musí řidič převzít odvážku.';

COMMENT ON COLUMN odvoz.stav
    IS 'Stav ve kterém se nachází odvoz.';

COMMENT ON TABLE pobocka
    IS 'Stará se o distribuci ke koncovým konzumentům.';

COMMENT ON COLUMN pobocka.nazev
    IS 'Pracovní název pobočky';

COMMENT ON TABLE pobocka_restaurace
    IS 'Kolik má která pobočka na skladě.';

COMMENT ON COLUMN pobocka_restaurace.mnozstvi
    IS 'množství daného restauračního produktu.';

COMMENT ON TABLE prodej
    IS 'Záznam o transakcích provedených dealery.';

COMMENT ON COLUMN prodej.datum
    IS 'Datum kdy prodej proběhl.';

COMMENT ON TABLE restauraceprodukty
    IS 'Produkty které se odváží a následně skladují na pobočkách.';

COMMENT ON COLUMN restauraceprodukty.cena
    IS 'Cena za jednu porci produktu.';

COMMENT ON COLUMN restauraceprodukty.nazev
    IS 'Prodejní název produktu.';

COMMENT ON TABLE ridic
    IS 'Role která se stará o převoz pervitinu a kuřat mezi pobočkami a centrálním skladem.';

COMMENT ON COLUMN ridic.maxnaklad
    IS 'Velikost nákladního prostoru auta.';

COMMENT ON TABLE pristupovaprava IS 'Práva pro přístup do různých částí databáze.';

COMMENT ON COLUMN pristupovaprava.nazev IS 'Název oprávnění/pozice která má tyto práva.';