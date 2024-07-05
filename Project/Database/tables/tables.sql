CREATE TABLE
  public.allergeni (nome character varying(50) NOT NULL);

ALTER TABLE
  public.allergeni
ADD
  CONSTRAINT allergeni_pkey PRIMARY KEY (nome);
  
CREATE TABLE
  public.borsellini (
    email character varying(50) NOT NULL,
    borsellino_id integer NOT NULL,
    saldo numeric(10, 2) NOT NULL
  );

ALTER TABLE
  public.borsellini
ADD
  CONSTRAINT borsellini_pkey PRIMARY KEY (borsellino_id);

  
CREATE TABLE
  public.codici_sconto (
    coupon_id character varying(10) NOT NULL,
    scadenza date NULL,
    valore numeric(10, 2) NULL
  );

ALTER TABLE
  public.codici_sconto
ADD
  CONSTRAINT codici_sconto_pkey PRIMARY KEY (coupon_id);

CREATE TABLE
  public.dettagli_ordini (
    dettaglio_id serial NOT NULL,
    numero_ordine bigint NOT NULL,
    totale numeric(10, 2) NULL,
    piatto_id integer NULL,
    restaurant_id integer NULL
  );

ALTER TABLE
  public.dettagli_ordini
ADD
  CONSTRAINT dettagli_ordini_pkey PRIMARY KEY (dettaglio_id);

CREATE TABLE
  public.ingredienti (nome character varying(50) NOT NULL);

ALTER TABLE
  public.ingredienti
ADD
  CONSTRAINT ingredienti_pkey PRIMARY KEY (nome);

  CREATE TABLE
  public.lista (
    nome_lista character varying(255) NOT NULL,
    lista_id serial NOT NULL
  );


ALTER TABLE
  public.lista
ADD
  CONSTRAINT lista_pkey PRIMARY KEY (lista_id);

CREATE TABLE
  public.messaggi (
    messaggio_id serial NOT NULL,
    ordine_id bigint NOT NULL,
    mittente_id integer NOT NULL,
    destinatario_id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_mittente character varying(20) NOT NULL,
    tipo_destinatario character varying(20) NOT NULL,
    contenuto text NULL,
    prec serial NOT NULL,
    succ serial NOT NULL
  );

ALTER TABLE
  public.messaggi
ADD
  CONSTRAINT messaggi_pkey PRIMARY KEY (messaggio_id);

CREATE TABLE
  public.metodi_di_pagamenti (
    metodo_id serial NOT NULL,
    tipo character varying(50) NULL,
    email character varying(50) NULL,
    borsellino_id integer NULL
  );

ALTER TABLE
  public.metodi_di_pagamenti
ADD
  CONSTRAINT metodi_di_pagamenti_pkey PRIMARY KEY (metodo_id);
  
CREATE TABLE
  public.mezzi (
    identificatore_veicolo character varying(20) NOT NULL,
    autonomia_residua numeric(10, 2) NULL,
    autonomia_totale numeric(10, 2) NULL,
    tipo_veicolo character varying(20) NULL
  );

ALTER TABLE
  public.mezzi
ADD
  CONSTRAINT mezzi_pkey PRIMARY KEY (identificatore_veicolo);

CREATE TABLE
  public.ordini (
    numero_ordine serial NOT NULL,
    posizione text NULL,
    data_ordine timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tempo_consegna integer NULL,
    stato character varying(50) NULL,
    mancia numeric(10, 2) NULL,
    restaurant_id integer NULL,
    email character varying(50) NOT NULL,
    rider_id serial NOT NULL,
    dettaglio_id serial NOT NULL
  );

ALTER TABLE
  public.ordini
ADD
  CONSTRAINT ordini_pkey PRIMARY KEY (numero_ordine);

CREATE TABLE
  public.piatti (
    piatto_id serial NOT NULL,
    restaurant_id integer NULL,
    nome character varying(100) NULL,
    descrizione text NULL,
    prezzo numeric(10, 2) NULL
  );

ALTER TABLE
  public.piatti
ADD
  CONSTRAINT piatti_pkey PRIMARY KEY (piatto_id);

CREATE TABLE
  public.piatto_allergeni (
    piatto_id integer NOT NULL,
    restaurant_id integer NOT NULL,
    nome_allergene character varying(50) NOT NULL
  );

ALTER TABLE
  public.piatto_allergeni
ADD
  CONSTRAINT piatto_allergeni_pkey PRIMARY KEY (nome_allergene);

CREATE TABLE
  public.piatto_ingredienti (
    piatto_id integer NOT NULL,
    restaurant_id integer NOT NULL,
    nome_ingrediente character varying(50) NOT NULL
  );

ALTER TABLE
  public.piatto_ingredienti
ADD
  CONSTRAINT piatto_ingredienti_pkey PRIMARY KEY (nome_ingrediente);
  
CREATE TABLE
  public.piatto_lista (
    piatto_id integer NOT NULL,
    restaurant_id integer NOT NULL,
    nome_lista character varying(255) NOT NULL,
    lista_id serial NOT NULL
  );

ALTER TABLE
  public.piatto_lista
ADD
  CONSTRAINT piatto_lista_pkey PRIMARY KEY (lista_id);

CREATE TABLE
  public.reclami (
    reclamo_id serial NOT NULL,
    descrizione text NULL,
    numero_ordine bigint NOT NULL
  );

ALTER TABLE
  public.reclami
ADD
  CONSTRAINT reclami_pkey PRIMARY KEY (numero_ordine);

CREATE TABLE
  public.riders (
    rider_id serial NOT NULL,
    mezzo_id character varying(20) NULL,
    nome character varying(50) NULL,
    posizione text NULL
  );

ALTER TABLE
  public.riders
ADD
  CONSTRAINT riders_pkey PRIMARY KEY (rider_id);

CREATE TABLE
  public.ristoranti (
    restaurant_id serial NOT NULL,
    nome_ristorante character varying(255) NOT NULL,
    posizione text NULL,
    costo_spedizione numeric(10, 2) NULL,
    categoria character varying(255) NULL,
    descrizione text NULL,
    immagine_profilo text NULL,
    premium_partner boolean NULL DEFAULT false,
    numero_stelle numeric(2, 1) NULL
  );

ALTER TABLE
  public.ristoranti
ADD
  CONSTRAINT ristoranti_pkey PRIMARY KEY (restaurant_id);

CREATE TABLE
  public.tipi_di_pagamento (tipo character varying(50) NOT NULL);

ALTER TABLE
  public.tipi_di_pagamento
ADD
  CONSTRAINT tipi_di_pagamento_pkey PRIMARY KEY (tipo);

CREATE TABLE
  public.tipo_utente (tipo character varying(20) NOT NULL);

ALTER TABLE
  public.tipo_utente
ADD
  CONSTRAINT tipo_utente_pkey PRIMARY KEY (tipo);

CREATE TABLE
  public.tipo_veicolo (tipo character varying(20) NOT NULL);

ALTER TABLE
  public.tipo_veicolo
ADD
  CONSTRAINT tipo_veicolo_pkey PRIMARY KEY (tipo);

CREATE TABLE
  public.utenti (
    email character varying(50) NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    password character varying(30) NOT NULL,
    numero_telefono character varying(30) NULL,
    indirizzo text NULL,
    premium boolean NULL DEFAULT false,
    borsellino_id integer NOT NULL
  );

ALTER TABLE
  public.utenti
ADD
  CONSTRAINT utenti_pkey PRIMARY KEY (email);
CREATE TABLE
  public.utilizzo_codici_sconto (
    utilizzo_id serial NOT NULL,
    coupon_id character varying(10) NULL,
    email character varying(50) NULL,
    borsellino_id integer NULL
  );

ALTER TABLE
  public.utilizzo_codici_sconto
ADD
  CONSTRAINT utilizzo_codici_sconto_pkey PRIMARY KEY (utilizzo_id);
