CREATE TABLE utenti (
    user_id INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    numero_telefono VARCHAR(30),
    indirizzo TEXT,
    premium BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_id)
);


-- Creazione della tabella Ristorante
CREATE TABLE ristoranti (
    restaurant_id INT AUTO_INCREMENT,
    nome_ristorante VARCHAR(255) NOT NULL,
    posizione TEXT,
    costo_spedizione NUMERIC(10, 2),
    categoria VARCHAR(255),
    descrizione TEXT,
    immagine_profilo TEXT,
    premium_partner BOOLEAN DEFAULT FALSE,
    numero_stelle NUMERIC(1, 1),
  	PRIMARY KEY (restaurant_id)
);

CREATE TABLE recensioni_ristoranti (
    review_id INT AUTO_INCREMENT,
    stelle INT CHECK (stelle >= 1 AND stelle <= 5),
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    titolo VARCHAR(255),
    restaurant_id INT,
    user_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES ristoranti(restaurant_id),
    FOREIGN KEY (user_id) REFERENCES utenti(user_id),
    PRIMARY KEY (review_id)
);

/* Tabelle per creazione */

CREATE TABLE mezzi (
    mezzo_ID SERIAL PRIMARY KEY,
    autonomia_residua NUMERIC(10, 2),
    rider_ID INTEGER,
    autonomia_totale NUMERIC(10, 2)
);

-- Creazione della tabella Rider senza chiave esterna a Mezzo
CREATE TABLE riders (
    rider_ID INT PRIMARY KEY,
    mezzo_ID SERIAL,
    nome VARCHAR(50),
    posizione TEXT
);

-- Aggiornamento della tabella Mezzo con il vincolo di chiave esterna a Rider
ALTER TABLE mezzi
ADD CONSTRAINT fk_rider
FOREIGN KEY (rider_ID) REFERENCES riders(rider_ID);

-- Aggiornamento della tabella Rider con il vincolo di chiave esterna a Mezzo
ALTER TABLE riders
ADD CONSTRAINT fk_mezzo
FOREIGN KEY (mezzo_ID) REFERENCES mezzi(mezzo_ID);


/** Tabelle per Relazione */

-- CREATE TABLE mezzi (
--     mezzo_ID SERIAL,
--     autonomia_residua NUMERIC(10, 2),
--     rider_ID INT,
--     autonomia_totale NUMERIC(10, 2),
--     FOREIGN KEY (rider_ID) REFERENCES riders(rider_ID),
--     PRIMARY KEY (mezzo_ID)
-- );

-- CREATE TABLE riders (
--     rider_ID INT,
--     mezzo_ID SERIAL,
--     posizione TEXT,
--     FOREIGN KEY (mezzo_ID) REFERENCES mezzi(mezzo_ID),
--     PRIMARY KEY (rider_ID)
-- );


-- Creazione della tabella Ordine
CREATE TABLE ordini (
    numero_ordine SERIAL,
    posizione TEXT,
    data_ordine TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tempo_consegna INT,
    stato VARCHAR(50),
    mancia NUMERIC(10, 2),
    restaurant_id INTEGER,
    user_id INTEGER,
    rider_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES utenti(user_id),
    FOREIGN KEY(restaurant_id) REFERENCES ristoranti(restaurant_id),
    FOREIGN KEY(rider_id) REFERENCES riders(rider_id),
    PRIMARY KEY(numero_ordine)
);


CREATE TABLE dettagli_ordini (
    dettaglio_id SERIAL,
    numero_ordine BIGINT UNSIGNED NOT NULL,
    totale NUMERIC(10, 2),
    piatto_id INT,
    restaurant_id INTEGER,
    PRIMARY KEY(dettaglio_id),
    FOREIGN KEY(restaurant_id) REFERENCES ristoranti(restaurant_id),
    FOREIGN KEY(numero_ordine) REFERENCES ordini(numero_ordine)
);

-- Creazione della tabella Piatto
CREATE TABLE piatti (
    piatto_id SERIAL,
    nome VARCHAR(255) NOT NULL,
    prezzo NUMERIC(10, 2),
    sconto NUMERIC(5, 2),
    immagine TEXT,
    restaurant_id INT,
    dettaglio_id BIGINT UNSIGNED NOT NULL,
  	PRIMARY KEY (piatto_id),
  	FOREIGN KEY (restaurant_id) REFERENCES ristoranti(restaurant_id),
  	FOREIGN KEY(dettaglio_id) REFERENCES dettagli_ordini(dettaglio_id)
);

CREATE TABLE ingredienti(
	nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE allergeni(
	nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome)
);



--Modificazione per aggiungere refernza
	ALTER TABLE dettagli_ordini
    ADD CONSTRAINT fk_piatto
    FOREIGN KEY (piatto_id) REFERENCES piatti(piatto_id);


-- Creazione della tabella Reclamo
CREATE TABLE Reclamo (
    reclamo_id SERIAL,
    descrizione TEXT,
  	numero_ordine BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(reclamo_id),
  	FOREIGN KEY(numero_ordine) REFERENCES ordini(numero_ordine)
);


-- Creazione della tabella Borsellino
CREATE TABLE borsellini (
    borsellino_ID INT AUTO_INCREMENT,
    saldo NUMERIC(10, 2),
    user_ID INT,
    PRIMARY KEY(borsellino_ID),
    FOREIGN KEY(user_ID) REFERENCES utenti(user_id)
);

-- Creazione della tabella Metodo_di_pagamento
CREATE TABLE metodi_di_pagamenti (
    metodo_ID INT AUTO_INCREMENT,
    tipo VARCHAR(50),
    user_ID INT,
    PRIMARY KEY(metodo_ID),
    FOREIGN KEY(user_ID) REFERENCES utenti(user_id)
);

-- Creazione della tabella Codice_sconto
CREATE TABLE codici_sconto (
    coupon_id INT AUTO_INCREMENT,
    scadenza DATE,
    valore NUMERIC(10, 2),
    PRIMARY KEY(coupon_id)
);


-- Creazione del tipo ENUM simulato con un campo VARCHAR
CREATE TABLE tipo_utente (
    tipo VARCHAR(20) PRIMARY KEY
);

-- Inserimento dei valori ENUM
INSERT INTO tipo_utente (tipo) VALUES ('Utente'), ('Ristoratore'), ('Rider');

-- Creazione della tabella Messaggio
CREATE TABLE messaggi (
    messaggio_id INT AUTO_INCREMENT,
    mittente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_mittente VARCHAR(20) NOT NULL,
    tipo_destinatario VARCHAR(20) NOT NULL,
    contenuto TEXT,
    PRIMARY KEY(messaggio_id),
    FOREIGN KEY(tipo_mittente) REFERENCES tipo_utente(tipo),
    FOREIGN KEY(tipo_destinatario) REFERENCES tipo_utente(tipo)
);

-- Creazione tabella recensioni dei rider
CREATE TABLE recensioni_rider (
  recensione_id INT,
  user_id INT,
	stelle INT CHECK (stelle >= 1 AND stelle <= 5),
  FOREIGN KEY (user_id) REFERENCES utenti(user_id),
  PRIMARY KEY (recensione_id)
);






