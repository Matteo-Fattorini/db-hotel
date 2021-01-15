●	Seleziona tutti gli ospiti che sono stati identificati con la carta di identità

SELECT * from ospiti
WHERE document_type = "CI";
___________________________________________


●	Seleziona tutti gli ospiti che sono nati dopo il 1988

SELECT * FROM `ospiti` 
WHERE  date_of_birth > "1988-01-01";
___________________________________________

●	Seleziona tutti gli ospiti che hanno più di 20 anni (al momento dell’esecuzione della query)

SELECT * FROM `ospiti` 
WHERE TIMESTAMPDIFF(year,date_of_birth, CURRENT_DATE ) > 20;
___________________________________________

●	Seleziona tutti gli ospiti il cui nome inizia con la D

SELECT * FROM `ospiti` 
WHERE name LIKE "D%";
___________________________________________

●	Calcola il totale degli ordini accepted

SELECT COUNT(*) as "numero prenotazioni confermate" FROM prenotazioni;

___________________________________________

●	Qual è il prezzo massimo pagato?

SELECT max(price) FROM pagamenti;

___________________________________________

●	Seleziona gli ospiti riconosciuti con patente e nati nel 1975

SELECT * FROM ospiti 
WHERE document_type = "Driver License" 
AND YEAR(date_of_birth) = "1975";

___________________________________________

●	Quanti paganti sono anche ospiti?

SELECT count(*) FROM ospiti 
JOIN paganti
ON paganti.ospite_id = ospiti.id;

●	Quanti posti letto ha l’hotel in totale?

SELECT SUM(beds) from stanze






___________________________________________
___________________________________________

●	Conta gli ospiti raggruppandoli per anno di nascita

SELECT count(*), YEAR(date_of_birth) FROM ospiti
GROUP BY YEAR(date_of_birth);


___________________________________________

●	Somma i prezzi dei pagamenti raggruppandoli per status

SELECT SUM(price), pagamenti.status FROM pagamenti
GROUP BY pagamenti.status;

___________________________________________

●	Conta quante volte è stata prenotata ogni stanza

SELECT stanza_id, COUNT(*) FROM prenotazioni
GROUP BY stanza_id;

●	Fai una analisi per vedere se ci sono ore in cui le prenotazioni sono più frequenti

SELECT HOUR(updated_at), COUNT(*) FROM prenotazioni
GROUP BY HOUR(updated_at)
ORDER BY COUNT(*) DESC;

___________________________________________

●	Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?

SELECT ospite_id, COUNT(*) FROM prenotazioni_has_ospiti
GROUP BY ospite_id
ORDER BY COUNT(*) DESC;



___________________________________________
___________________________________________

●	Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?

SELECT ospiti.name, COUNT(*) FROM prenotazioni_has_ospiti
JOIN ospiti
ON ospiti.id = prenotazioni_has_ospiti.ospite_id
GROUP BY ospite_id
HAVING COUNT(*) > 2

___________________________________________

●	Stampare tutti gli ospiti per ogni prenotazione

SELECT ospiti.name, prenotazioni_has_ospiti.prenotazione_id FROM prenotazioni_has_ospiti
JOIN ospiti
ON ospiti.id = prenotazioni_has_ospiti.ospite_id

___________________________________________

●	Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018

SELECT prenotazioni.created_at, ospiti.name, ospiti.lastname, pagamenti.price, paganti.name FROM prenotazioni
JOIN prenotazioni_has_ospiti
ON prenotazioni_has_ospiti.prenotazione_id = prenotazioni.id
JOIN ospiti
ON ospiti.id = prenotazioni_has_ospiti.ospite_id
JOIN pagamenti
ON pagamenti.prenotazione_id = prenotazioni.id
LEFT JOIN paganti
ON paganti.ospite_id = ospiti.id
WHERE YEAR(prenotazioni.created_at) = "2018" AND MONTH(prenotazioni.created_at) = "05"

___________________________________________

●	Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano

SELECT SUM(pagamenti.price) FROM stanze
JOIN prenotazioni
ON prenotazioni.stanza_id = stanze.id
JOIN pagamenti
ON pagamenti.prenotazione_id = prenotazioni.id
WHERE stanze.floor = 1

___________________________________________

●	Prendi i dati di fatturazione per la prenotazione con id=7

SELECT * FROM prenotazioni
JOIN prenotazioni_has_ospiti
ON prenotazioni_has_ospiti.prenotazione_id = prenotazioni.id
JOIN ospiti
ON ospiti.id = prenotazioni_has_ospiti.ospite_id
JOIN pagamenti
ON pagamenti.prenotazione_id = prenotazioni.id
JOIN paganti
ON paganti.id = pagamenti.pagante_id
WHERE prenotazioni.id = 7;

___________________________________________

●	Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)

SELECT *
FROM prenotazioni
RIGHT JOIN stanze 
ON prenotazioni.stanza_id = stanze.id
WHERE
prenotazioni.stanza_id IS NULL;

