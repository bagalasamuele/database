
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

CREATE TABLE borsellini (
    email VARCHAR(50) NOT NULL,
    borsellino_ID INT NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (email, borsellino_ID)
);

INSERT INTO borsellini (email, borsellino_ID, saldo)
VALUES
    ('user1@example.com', 1, 0.00),
    ('user2@example.com', 2, 0.00),
    ('user3@example.com', 3, 0.00),
    ('user4@example.com', 4, 0.00),
    ('user5@example.com', 5, 0.00);

INSERT INTO utenti (email, nome, cognome, password, numero_telefono, indirizzo, premium, borsellino_ID)
VALUES
    ('user1@example.com', 'Samuele', 'Bagala', 'password1', '1234567890', 'Via Roma 1', TRUE, 1),
    ('user2@example.com', 'Giuseppe', 'Barrile', 'password2', '0987654321', 'Via Garibaldi 2', FALSE, 2),
    ('user3@example.com', 'Giulia', 'Verdi', 'password3', NULL, 'Via Dante 3', FALSE, 3),
    ('user4@example.com', 'Anna', 'Neri', 'password4', '2345678901', 'Via Manzoni 4', TRUE, 4),
    ('user5@example.com', 'Paolo', 'Gialli', 'password5', '3456789012', 'Corso Vittorio Emanuele 5', TRUE, 5);

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

CREATE TABLE tipi_di_pagamento (
    tipo VARCHAR(50) PRIMARY KEY
);

INSERT INTO tipi_di_pagamento (tipo)
VALUES
    ('PayPal'),
    ('Satispay'),
    ('Carta di credito'),
    ('Bonifico bancario');


INSERT INTO metodi_di_pagamenti (tipo, email, borsellino_ID)
VALUES
    ('PayPal', 'user1@example.com', 1),
    ('Satispay', 'user2@example.com', 2),
    ('Carta di credito', 'user3@example.com', 3),
    ('Bonifico bancario', 'user4@example.com', 4),
    ('PayPal', 'user5@example.com', 5);

INSERT INTO codici_sconto (coupon_id, scadenza, valore)
VALUES
    ('ABC123', '2024-12-31', 10.00),
    ('DEF456', '2024-11-30', 5.00),
    ('GHI789', '2024-10-15', 15.00),
    ('JKL012', '2024-09-30', 20.00),
    ('MNO345', '2024-08-31', 8.50);

CREATE TABLE utilizzo_codici_sconto (
    utilizzo_id SERIAL PRIMARY KEY,
    coupon_id VARCHAR(10),
    email VARCHAR(50),  -- Supponendo che l'email identifichi l'utente che ha utilizzato il codice sconto
    borsellino_ID INT,  -- Supponendo che borsellino_ID identifichi il metodo di pagamento a cui è stato applicato il codice sconto
    FOREIGN KEY (coupon_id) REFERENCES codici_sconto(coupon_id),
    FOREIGN KEY (email, borsellino_ID) REFERENCES borsellini(email, borsellino_ID)
);

INSERT INTO utilizzo_codici_sconto (coupon_id, email, borsellino_ID)
VALUES ('ABC123', 'user1@example.com', 1);

INSERT INTO utilizzo_codici_sconto (coupon_id, email, borsellino_ID)
VALUES ('DEF456', 'user2@example.com', 2);

-- Utente 3 utilizza il codice sconto GHI789
INSERT INTO utilizzo_codici_sconto (coupon_id, email, borsellino_ID)
VALUES ('GHI789', 'user3@example.com', 3);


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

INSERT INTO ristoranti (nome_ristorante, posizione, costo_spedizione, categoria, descrizione, immagine_profilo, premium_partner, numero_stelle)
VALUES
    ('Gusto Italiano', 'Via Roma 1', 3.50, 'Italiana', 'Autentica cucina italiana con specialità regionali', 'url_immagine1', TRUE, 4.5),
    ('Pizza Napoletana', 'Via Garibaldi 2', 4.00, 'Pizza', 'Pizzeria con pizza napoletana e ingredienti freschi', 'url_immagine2', FALSE, 4.2),
    ('Sushi Dreams', 'Piazza Duomo 3', 5.00, 'Giapponese', 'Ristorante giapponese con sushi fresco e creativo', 'url_immagine3', TRUE, 4.8),
    ('Burger Station', 'Corso Italia 4', 3.00, 'Fast Food', 'Specializzato in hamburger gourmet e patatine fritte', 'url_immagine4', FALSE, 3.9),
    ('Green Garden', 'Via Dante 5', 3.20, 'Vegetariana', 'Cucina vegetariana e vegana con ingredienti biologici', 'url_immagine5', TRUE, 4.6);


CREATE TABLE piatti (
    piatto_id INT,
    restaurant_id INTEGER,
    nome VARCHAR(100),
    descrizione TEXT,
    prezzo NUMERIC(10, 2),
    PRIMARY KEY (piatto_id, restaurant_id),  
    CONSTRAINT piatti_unique_piatto_restaurant UNIQUE (piatto_id, restaurant_id)
);

-- Gusto Italiano (Ristorante ID 1)
INSERT INTO piatti (restaurant_id, nome, descrizione, prezzo)
VALUES
    (1, 'Spaghetti alla Carbonara', 'Pasta con uova, guanciale e pecorino romano', 10.50),
    (1, 'Saltimbocca alla Romana', 'Fettine di vitello con prosciutto crudo e salvia', 15.00),
    (1, 'Tiramisù', 'Dolce italiano al caffè con mascarpone e cacao', 7.00);

-- Pizza Napoletana (Ristorante ID 2)
INSERT INTO piatti (restaurant_id, nome, descrizione, prezzo)
VALUES
    (2, 'Pizza Margherita', 'Pizza con pomodoro, mozzarella e basilico', 8.00),
    (2, 'Pizza Capricciosa', 'Pizza con pomodoro, mozzarella, prosciutto cotto, funghi e olive', 10.00),
    (2, 'Calzone', 'Pizza chiusa a forma di mezzaluna con ripieno di pomodoro e mozzarella', 9.50),
    (2, 'Torta Caprese', 'Torta al cioccolato e mandorle tipica della tradizione partenopea', 6.50);

-- Sushi Dreams (Ristorante ID 3)
INSERT INTO piatti (restaurant_id, nome, descrizione, prezzo)
VALUES
    (3, 'Sashimi Misto', 'Assortimento di pesce crudo tagliato a fettine', 18.00),
    (3, 'Nigiri Sushi', 'Sushi con riso e pezzo di pesce crudo o altro ingrediente sopra', 4.50),
    (3, 'Tempura', 'Frittura giapponese di gamberi e verdure in pastella croccante', 12.00),
    (3, 'Matcha Tiramisu', 'Tiramisù al tè verde matcha giapponese', 8.50);

-- Burger Station (Ristorante ID 4)
INSERT INTO piatti (restaurant_id, nome, descrizione, prezzo)
VALUES
    (4, 'Hamburger Classico', 'Hamburger con carne di manzo, lattuga, pomodoro e salsa', 7.00),
    (4, 'Cheeseburger', 'Hamburger con formaggio cheddar fuso', 8.00),
    (4, 'Patatine Fritte', 'Patatine tagliate a bastoncino e fritte', 3.50);

-- Green Garden (Ristorante ID 5)
INSERT INTO piatti (restaurant_id, nome, descrizione, prezzo)
VALUES
    (5, 'Insalata Vegana', 'Insalata mista con verdure fresche e tofu', 9.00),
    (5, 'Lasagne Vegetariane', 'Lasagne con ragù di verdure e besciamella', 11.50),
    (5, 'Smoothie Detox', 'Frullato di frutta e verdura per purificare il corpo', 6.50),
    (5, 'Crostata ai Frutti di Bosco', 'Dolce con base di pasta frolla e frutti di bosco freschi', 5.50);
