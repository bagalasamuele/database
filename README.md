# Esame del 8 luglio alle 10:00

## Dettagli dell'esame

- **Data e ora:** 8 luglio 2024, ore 10:00
- **Formato:** Esame composto da una parte scritta e un progetto
  - Lo scritto si terrà l'8 luglio
  - La discussione del progetto si terrà in data da definire, concordata con il professore

# Progetto

## il progetto va consegnato entro il 4 luglio alle 23:59

[Link Moodle Unito - Consegna Progetto](https://informatica.i-learn.unito.it/mod/assign/view.php?id=235786)

## Link alla relazione

La relazione per il progetto è in fase di scrittura ed è disponibile al seguente link:

[Documento Google Docs - Relazione del Progetto](https://docs.google.com/document/d/1DzxUjuaCh5eImsaroqHq8j8oPXeEQ7thTz5TV4AdffI/)

## Production Database:
https://out106.keliweb.com/phpmyadmin/

## Software richiesti:

**Locale:**
XAMPP, Beekeeper, MariaDB

**Prod:**
Connettersi al phpMyAdmin


## Formulario Teoria ##

# Algebra Relazionale

## 1. Selezione (σ)

**Descrizione:** Seleziona le tuple di una relazione che soddisfano una determinata condizione.  
**Sintassi:** σ<sub>condizione</sub>(R)  
**Esempio:** σ<sub>età > 30</sub>(Impiegati)  
**Risultato:** Seleziona tutte le tuple della relazione Impiegati dove l'attributo età è maggiore di 30.

## 2. Proiezione (π)

**Descrizione:** Seleziona specifici attributi di una relazione, eliminando i duplicati.  
**Sintassi:** π<sub>attributi</sub>(R)  
**Esempio:** π<sub>nome, età</sub>(Impiegati)  
**Risultato:** Seleziona i campi nome ed età dalla relazione Impiegati, rimuovendo i duplicati.

## 3. Unione (∪)

**Descrizione:** Combina le tuple di due relazioni, rimuovendo i duplicati. Le relazioni devono essere compatibili (stessi attributi).  
**Sintassi:** R ∪ S  
**Esempio:** Clienti ∪ Fornitori  
**Risultato:** Una relazione che contiene tutte le tuple di Clienti e Fornitori.

## 4. Intersezione (∩)

**Descrizione:** Seleziona le tuple presenti in entrambe le relazioni.  
**Sintassi:** R ∩ S  
**Esempio:** Clienti ∩ Fornitori  
**Risultato:** Una relazione che contiene solo le tuple comuni a Clienti e Fornitori.

## 5. Differenza (−)

**Descrizione:** Seleziona le tuple presenti in una relazione ma non nell'altra.  
**Sintassi:** R − S  
**Esempio:** Clienti − Fornitori  
**Risultato:** Una relazione che contiene le tuple di Clienti che non sono presenti in Fornitori.

## 6. Prodotto Cartesiano (×)

**Descrizione:** Combina ogni tupla di una relazione con ogni tupla di un'altra relazione.  
**Sintassi:** R × S  
**Esempio:** Impiegati × Dipartimenti  
**Risultato:** Una relazione contenente tutte le possibili combinazioni di tuple di Impiegati e Dipartimenti.

## 7. Join Naturale (⋈)

**Descrizione:** Combina le tuple di due relazioni basandosi su attributi con lo stesso nome e valori.  
**Sintassi:** R ⋈ S  
**Esempio:** Impiegati ⋈ Dipartimenti  
**Risultato:** Una relazione che combina Impiegati e Dipartimenti dove gli attributi comuni hanno lo stesso valore.

## 8. Theta Join (⋈<sub>θ</sub>)

**Descrizione:** Combina le tuple di due relazioni basandosi su una condizione arbitraria.  
**Sintassi:** R ⋈<sub>θ</sub> S  
**Esempio:** Impiegati ⋈<sub>Impiegati.depId = Dipartimenti.id</sub> Dipartimenti  
**Risultato:** Una relazione che combina Impiegati e Dipartimenti dove la condizione Impiegati.depId = Dipartimenti.id è soddisfatta.

## 9. Divisione (÷)

**Descrizione:** Seleziona le tuple di una relazione che sono associate a tutte le tuple di un'altra relazione.  
**Sintassi:** R ÷ S  
**Esempio:** Progetti ÷ Competenze  
**Risultato:** Una relazione che contiene le tuple di Progetti che sono associate a tutte le tuple di Competenze.

## 10. Ridenominazione (ρ)

**Descrizione:** Rinomina una relazione o i suoi attributi.  
**Sintassi:** ρ<sub>nuovoNome(attr1, attr2, ...)</sub>(R)  
**Esempio:** ρ<sub>Dipendenti(n, e)</sub>(Impiegati)  
**Risultato:** Rinomina la relazione Impiegati in Dipendenti e i suoi attributi in n ed e.

## Esempi di Utilizzo

### 1. Selezione e Proiezione Combinata

**Esempio:** Trova i nomi di tutti gli impiegati con età maggiore di 30.  
**Query:** π<sub>nome</sub>(σ<sub>età > 30</sub>(Impiegati))

### 2. Join Naturale

**Esempio:** Trova i nomi degli impiegati e i nomi dei loro dipartimenti.  
**Query:** π<sub>Impiegati.nome, Dipartimenti.nome</sub>(Impiegati ⋈ Dipartimenti)

### 3. Unione e Differenza

**Esempio:** Trova tutti i clienti che non sono fornitori.  
**Query:** Clienti − Fornitori

## Notazione Sintattica

- **Relazione:** Denotata con lettere maiuscole (es. R, S, T).
- **Attributi:** Denotati con lettere minuscole (es. a, b, c).
- **Condizioni:** Espresse come condizione (es. età > 30).

Questo formulario dovrebbe coprire le operazioni di base dell'algebra relazionale e fornire esempi di come utilizzarle.
