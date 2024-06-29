-- Creazione della tabella Utente
CREATE TABLE Utente (
    user_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cognome VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    numero_telefono VARCHAR(20),
    indirizzo TEXT,
    premium BOOLEAN DEFAULT FALSE
);

-- Creazione della tabella Ristorante
CREATE TABLE Ristorante (
    restaurant_ID SERIAL PRIMARY KEY,
    nome_ristorante VARCHAR(255) NOT NULL,
    posizione TEXT,
    costo_spedizione NUMERIC(10, 2),
    categoria VARCHAR(255),
    descrizione TEXT,
    immagine_profilo TEXT,
    premium_partner BOOLEAN DEFAULT FALSE,
    numero_stelle NUMERIC(1, 1)
);

-- Creazione della tabella Recensione_ristorante
CREATE TABLE Recensione_ristorante (
    review_ID SERIAL PRIMARY KEY,
    stelle INTEGER CHECK (stelle >= 1 AND stelle <= 5),
    restaurant_ID INTEGER REFERENCES Ristorante(restaurant_ID),
    user_ID INTEGER REFERENCES Utente(user_id),
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    titolo VARCHAR(255)
);

-- Creazione della tabella Rider
CREATE TABLE Rider (
    rider_ID SERIAL PRIMARY KEY,
    mezzo_ID INTEGER REFERENCES Mezzo(mezzo_ID),
    posizione TEXT
);

-- Creazione della tabella Recensione_rider
CREATE TABLE Recensione_rider (
    recensione_ID SERIAL PRIMARY KEY,
    user_ID INTEGER REFERENCES Utente(user_id),
    rider_ID INTEGER REFERENCES Rider(rider_ID),
    commento TEXT,
    stelle INTEGER CHECK (stelle >= 1 AND stelle <= 5)
);

-- Creazione della tabella Mezzo
CREATE TABLE Mezzo (
    mezzo_ID SERIAL PRIMARY KEY,
    autonomia_residua NUMERIC(10, 2),
    rider_ID INTEGER REFERENCES Rider(rider_ID),
    autonomia_totale NUMERIC(10, 2)
);

-- Creazione della tabella Piatto
CREATE TABLE Piatto (
    piatto_ID SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    restaurant_ID INTEGER REFERENCES Ristorante(restaurant_ID),
    prezzo NUMERIC(10, 2),
    dettaglio_ID INTEGER REFERENCES Dettaglio_ordine(dettaglio_ID), 
    sconto NUMERIC(5, 2),
    immagine TEXT
);

-- Creazione della tabella Ordine
CREATE TABLE Ordine (
    numero_ordine SERIAL PRIMARY KEY,
    user_ID INTEGER REFERENCES Utente(user_id),
    restaurant_ID INTEGER REFERENCES Ristorante(restaurant_ID),
    posizione TEXT,
    data_ordine TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    rider_ID INTEGER REFERENCES Rider(rider_ID),
    tempo_consegna INTERVAL,
    stato VARCHAR(50),
    mancia NUMERIC(10, 2)
);

CREATE TYPE tipo_utente AS ENUM ('Utente', 'Ristoratore', 'Rider');

-- Creazione della tabella Messaggio
CREATE TABLE Messaggio (
    messaggio_ID SERIAL PRIMARY KEY,
    mittente_ID INTEGER NOT NULL,
    destinatario_ID INTEGER NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_mittente tipo_utente NOT NULL,
    tipo_destinatario tipo_utente NOT NULL,
    contenuto TEXT
);

-- Creazione della tabella Dettaglio ordine
CREATE TABLE Dettaglio_ordine (
    numero_ordine INTEGER REFERENCES Ordine(numero_ordine),
    dettaglio_ID SERIAL PRIMARY KEY,
    totale NUMERIC(10, 2),
    ID_piatto INTEGER REFERENCES Piatto(piatto_ID),
    restaurant_ID INTEGER REFERENCES Ristorante(restaurant_ID)
);

-- Creazione della tabella Reclamo
CREATE TABLE Reclamo (
    reclamo_ID SERIAL PRIMARY KEY,
    descrizione TEXT
);

-- Creazione della tabella Borsellino
CREATE TABLE Borsellino (
    user_ID INTEGER REFERENCES Utente(user_id),
    borsellino_ID SERIAL PRIMARY KEY,
    saldo NUMERIC(10, 2)
);

-- Creazione della tabella Metodo_di_pagamento
CREATE TABLE Metodo_di_pagamento (
    user_ID INTEGER REFERENCES Utente(user_id),
    metodo_ID SERIAL PRIMARY KEY,
    tipo VARCHAR(50)
);

-- Creazione della tabella Codice_sconto
CREATE TABLE Codice_sconto (
    coupon_ID SERIAL PRIMARY KEY,
    validità DATE,
    valore NUMERIC(10, 2)
);
