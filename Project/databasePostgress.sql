CREATE TABLE utenti (
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    numero_telefono VARCHAR(30),
    indirizzo TEXT,
    premium BOOLEAN DEFAULT FALSE,
    borsellino_ID INT NOT NULL,
    PRIMARY KEY (email)
);

--- Pagamenti ---

CREATE TABLE borsellini (
    email VARCHAR(50) NOT NULL,
    borsellino_ID INT NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (email, borsellino_ID),
    FOREIGN KEY (email) REFERENCES utenti(email)
);

ALTER TABLE utenti
ADD CONSTRAINT fk_utenti_borsellini
FOREIGN KEY (email, borsellino_ID) REFERENCES borsellini(email, borsellino_ID);


CREATE TABLE metodi_di_pagamenti (
    metodo_ID SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    email VARCHAR(50),
    borsellino_ID INT,
    FOREIGN KEY (email, borsellino_ID) REFERENCES borsellini(email, borsellino_ID)
);

CREATE TABLE codici_sconto (
    coupon_id VARCHAR(10) UNIQUE,
    scadenza DATE,
    valore NUMERIC(10, 2),
    PRIMARY KEY (coupon_id)
);


CREATE TABLE tipi_di_pagamento (
    tipo VARCHAR(50) PRIMARY KEY
);

INSERT INTO tipi_di_pagamento (tipo)
VALUES
    ('PayPal'),
    ('Satispay'),
    ('Carta di credito'),
    ('Bonifico bancario');


--- Ordini ---

CREATE TABLE ordini (
    numero_ordine SERIAL PRIMARY KEY,
    posizione TEXT,
    data_ordine TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tempo_consegna INT,
    stato VARCHAR(50),
    mancia NUMERIC(10, 2),
    restaurant_id INTEGER,
    email VARCHAR(50) NOT NULL,
    rider_id SERIAL,
    FOREIGN KEY (email) REFERENCES utenti(email),
    FOREIGN KEY (restaurant_id) REFERENCES ristoranti(restaurant_id),
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id)
);


CREATE TABLE dettagli_ordini (
    dettaglio_id SERIAL PRIMARY KEY,
    numero_ordine BIGINT NOT NULL,
    totale NUMERIC(10, 2),
    piatto_id INT,
    restaurant_id INTEGER,
    FOREIGN KEY (restaurant_id) REFERENCES ristoranti(restaurant_id),
    FOREIGN KEY (numero_ordine) REFERENCES ordini(numero_ordine),
    FOREIGN KEY (piatto_id, restaurant_id) REFERENCES piatti(piatto_id, restaurant_id)
);

CREATE TABLE tipo_utente (
    tipo VARCHAR(20) PRIMARY KEY
);

-- Inserimento dei valori ENUM
INSERT INTO tipo_utente (tipo) VALUES ('Utente'), ('Ristoratore'), ('Rider');

CREATE TABLE messaggi (
    messaggio_id SERIAL PRIMARY KEY,
    ordine_id BIGINT NOT NULL,
    mittente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_mittente VARCHAR(20) NOT NULL,
    tipo_destinatario VARCHAR(20) NOT NULL,
    contenuto TEXT,
    prec SERIAL,
    succ SERIAL,

    FOREIGN KEY (tipo_mittente) REFERENCES tipo_utente(tipo),
    FOREIGN KEY (tipo_destinatario) REFERENCES tipo_utente(tipo),
    FOREIGN KEY (prec) REFERENCES messaggi(messaggio_id),
    FOREIGN KEY (succ) REFERENCES messaggi(messaggio_id)
);

CREATE TABLE reclami (
    reclamo_id SERIAL,
    descrizione TEXT,
    numero_ordine BIGINT NOT NULL,
    PRIMARY KEY (reclamo_id, numero_ordine),
    FOREIGN KEY (numero_ordine) REFERENCES ordini(numero_ordine)
);

-- Creazione della tabella recensioni
CREATE TABLE recensioni (
    recensione_id SERIAL PRIMARY KEY,
    stelle INT CHECK (stelle >= 1 AND stelle <= 5),
    titolo VARCHAR(255),
    descrizione TEXT,
    tipo_recensione VARCHAR(20),
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    numero_ordine SERIAL,
    FOREIGN KEY (numero_ordine) REFERENCES ordini(numero_ordine),
    FOREIGN KEY (tipo_recensione) REFERENCES tipo_utente(tipo)
);


ALTER TABLE ordini
ADD COLUMN recensione_id SERIAL,
ADD CONSTRAINT fk_recensione_ordine
    FOREIGN KEY (recensione_id) REFERENCES recensioni(recensione_id);

--- Riders ---
CREATE TABLE riders (
    rider_ID SERIAL PRIMARY KEY,
    mezzo_ID INT,
    nome VARCHAR(50),
    posizione TEXT
);

CREATE TABLE mezzi (
    identificatore_veicolo SERIAL,
    autonomia_residua NUMERIC(10, 2),
    rider_ID INT,
    autonomia_totale NUMERIC(10, 2),
    PRIMARY KEY (identificatore_veicolo, rider_ID),
    UNIQUE (identificatore_veicolo),
    FOREIGN KEY (rider_ID) REFERENCES riders(rider_ID)
);

-- Aggiunta del vincolo di chiave esterna alla tabella Rider, va aggiuta dopo perche mezzi non esisteva ancora
ALTER TABLE riders
ADD CONSTRAINT fk_mezzo
FOREIGN KEY (mezzo_ID)
REFERENCES mezzi(identificatore_veicolo);


CREATE TABLE tipo_veicolo (
    tipo VARCHAR(20)
);

INSERT INTO tipo_veicolo (tipo) VALUES ('Monopattino'), ('Bici'), ('Bici Elettrica');


--- Ristoranti ---

CREATE TABLE ristoranti (
    restaurant_ID SERIAL PRIMARY KEY,
    nome_ristorante VARCHAR(255) NOT NULL,
    posizione TEXT,
    costo_spedizione NUMERIC(10, 2),
    categoria VARCHAR(255),
    descrizione TEXT,
    immagine_profilo TEXT,
    premium_partner BOOLEAN DEFAULT FALSE,
    numero_stelle NUMERIC(2, 1) CHECK (numero_stelle >= 1 AND numero_stelle <= 5)
);

--- Piatti ---

CREATE TABLE piatti (
    piatto_id INT,
    restaurant_id INTEGER,
    nome VARCHAR(100),
    descrizione TEXT,
    prezzo NUMERIC(10, 2),
    PRIMARY KEY (piatto_id, restaurant_id),  
    CONSTRAINT piatti_unique_piatto_restaurant UNIQUE (piatto_id, restaurant_id)
);


CREATE TABLE ingredienti(
	nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE allergeni(
	nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome)
);


CREATE TABLE lista (
    nome_lista VARCHAR(255) NOT NULL,
    lista_id SERIAL,
    PRIMARY KEY (nome_lista, lista_id)
);


CREATE TABLE piatto_ingredienti (
    piatto_id INT,
    restaurant_id INTEGER,
    nome_ingrediente VARCHAR(50),
    PRIMARY KEY (piatto_id, restaurant_id, nome_ingrediente),
    FOREIGN KEY (piatto_id, restaurant_id) REFERENCES piatti(piatto_id, restaurant_id),
    FOREIGN KEY (nome_ingrediente) REFERENCES ingredienti(nome)
);

CREATE TABLE piatto_allergeni (
    piatto_id INT,
    restaurant_id INTEGER,
    nome_allergene VARCHAR(50),
    PRIMARY KEY (piatto_id, restaurant_id, nome_allergene),
    FOREIGN KEY (piatto_id, restaurant_id) REFERENCES piatti(piatto_id, restaurant_id),
    FOREIGN KEY (nome_allergene) REFERENCES allergeni(nome)
);

CREATE TABLE piatto_lista (
    piatto_id INT,
    restaurant_id INTEGER,
    nome_lista VARCHAR(255),
    lista_id SERIAL,
    PRIMARY KEY (piatto_id, restaurant_id, nome_lista, lista_id),
    FOREIGN KEY (piatto_id, restaurant_id) REFERENCES piatti(piatto_id, restaurant_id),
    FOREIGN KEY (nome_lista, lista_id) REFERENCES lista(nome_lista, lista_id)
);


ALTER TABLE piatti
ADD COLUMN dettaglio_id SERIAL,
ADD CONSTRAINT fk_dettaglio_ordine
    FOREIGN KEY (dettaglio_id)
    REFERENCES dettagli_ordini(dettaglio_id);
