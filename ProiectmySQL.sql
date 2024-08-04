-- Creaza baza de date KissAndMakeup;
USE KissAndMakeup;

-- Creaza Tabelul Depozit
CREATE TABLE Depozit (
    id_locatie INT AUTO_INCREMENT PRIMARY KEY,
    tip_stocare VARCHAR(100) NOT NULL,
    unitati_per_cutie INT NOT NULL,
    raft VARCHAR(255) NOT NULL,
    cantitate INT NOT NULL
);

-- Creaza Tabelul Produse
CREATE TABLE Produse (
    id_intern_produs INT AUTO_INCREMENT PRIMARY KEY,
    nume_producator VARCHAR(100) NOT NULL,
    description TEXT,
    pret_unitar DECIMAL(10, 2) NOT NULL,
    id_locatie INT,
    FOREIGN KEY (id_locatie) REFERENCES Depozit(id_locatie)
);

-- Creaza Tabelul Adresa Facturare care contine si CUI pentru firme SRL/PFA
CREATE TABLE AdresaFacturare (
    id_adresa_facturare INT AUTO_INCREMENT PRIMARY KEY,
    cui VARCHAR(15),
    adresa VARCHAR(255),
    oras VARCHAR(50),
    judet VARCHAR(50),
    cod_postal VARCHAR(10),
    tara VARCHAR(50)
);

-- Creaza Tabelul Adresa Livrare ce poate contine o alta persoana ca persoana de contact
CREATE TABLE AdresaLivrare (
    id_adresa_livrare INT AUTO_INCREMENT PRIMARY KEY,
    persoana_contact VARCHAR(255),
    telefon_persoana_contact VARCHAR(15),
    adresa VARCHAR(255),
    oras VARCHAR(50),
    judet VARCHAR(50),
    cod_postal VARCHAR(10),
    tara VARCHAR(50)
);

-- Creaza Tabelul Clienti
CREATE TABLE Clienti (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(15),
    id_adresa_facturare INT,
    id_adresa_livrare INT,
    FOREIGN KEY (id_adresa_facturare) REFERENCES AdresaFacturare(id_adresa_facturare),
    FOREIGN KEY (id_adresa_livrare) REFERENCES AdresaLivrare(id_adresa_livrare)
);

-- Creaza Tabelul Comenzi - Typo corectat mai jos
CREATE TABLE Comezi (
    id_comanda INT AUTO_INCREMENT PRIMARY KEY,
    numar_comanda VARCHAR(20) NOT NULL UNIQUE,
    id_client INT,
    curier ENUM('FAN', 'SameDay', 'Cargus', 'DHL') NOT NULL,
    data_livrare DATE NOT NULL,
    tip_plata ENUM('cash', 'card') NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Clienti(id_client)
);

-- Creaza Tabelul Detalii Produse Comanda
CREATE TABLE DetaliiProduseComanda (
    id_detaliu INT AUTO_INCREMENT PRIMARY KEY,
    id_comanda INT,
    id_intern_produs INT,
    cantitate INT NOT NULL,
    pret_unitar DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES Comezi(id_comanda),
    FOREIGN KEY (id_intern_produs) REFERENCES Produse(id_intern_produs)
);

-- Verificare corectitudine tabele inainte de populare
DESCRIBE Depozit;
DESCRIBE Produse;
DESCRIBE Clienti;
DESCRIBE AdresaFacturare;
DESCRIBE AdresaLivrare;
DESCRIBE Comezi;
DESCRIBE DetaliiProduseComanda;

-- Schimbare nume camp tabel
ALTER TABLE Depozit
CHANGE tip_impachetare tip_stocare  VARCHAR(100);

-- Populare Tabele Depozit cu valori
INSERT INTO Depozit (id_locatie, tip_stocare, unitati_per_cutie, raft, cantitate) VALUES
(1001, 'Frigirific', 200, 'E540Vest', 2942),
(1002, 'Ambiant', 100, 'E501Sud', 10002),
(1003, 'Ambiant', 200, 'E501Sud', 90),
(1004, 'Frigirific', 150, 'E541Vest', 102),
(1005, 'Ambiant', 50, 'E502Sud', 25);

-- Verificare date introduse in tabel
SELECT * FROM Depozit;

-- Adaugate camp nou in tabelul produse
ALTER TABLE Produse
ADD cod_bare VARCHAR(13) UNIQUE;

-- Populare Tabel Produse cu valori
INSERT INTO Produse (id_intern_produs, nume_producator, cod_bare, description, pret_unitar, id_locatie) VALUES
(1, 'L''Oreal', '1234567890123', 'Lipstick Buze - Rosu', 15.99, 1001),
(2, 'Maybelline', '2345678901234', 'Mascara Gene- Negru Mat', 12.99, 1004),
(3, 'MAC', '3456789012345', 'Foundation Ochi - Ten deschis', 25.99, 1004),
(4, 'Revlon', '4567890123456', 'Blush Pudra- Roz', 18.99, 1005),
(5, 'Clinique', '5678901234567', 'Eyeliner Ochi- Maro', 9.99, 1005),
(6, 'Dior', '6789012345678', 'Paleta Ochi - Nude', 35.99, 1002),
(7, 'Estee Lauder', '7890123456789', 'Concealer - Medium', 14.99, 1002),
(8, 'NARS', '8901234567890', 'Highlighter - Stralucitor', 19.99, 1005);

-- Verificare date introduse in tabel
SELECT * FROM Produse;

-- Populare Tabel Adrese Livrare
INSERT INTO AdresaLivrare (persoana_contact, telefon_persoana_contact, adresa, oras, judet, cod_postal, tara) VALUES
('Ioan Popescu', '0712345678', 'Strada Victoriei 10', 'Bucuresti', 'Bucuresti', '010123', 'Romania'),
('Maria Ionescu', '0712345679', 'Bulevardul Unirii 20', 'Cluj-Napoca', 'Cluj', '400123', 'Romania'),
('Andrei Georgescu', '0712345680', 'Calea Dorobantilor 15', 'Timisoara', 'Timis', '300123', 'Romania'),
('Elena Dumitrescu', '0712345681', 'Strada Mare 5', 'Iasi', 'Iasi', '700123', 'Romania'),
('Mihai Vasilescu', '0712345682', 'Bulevardul Republicii 25', 'Constanta', 'Constanta', '900123', 'Romania'),
('Cristina Nistor', '0712345683', 'Strada Primaverii 7', 'Brasov', 'Brasov', '500123', 'Romania'),
('Alexandru Popa', '0712345684', 'Calea Mosilor 50', 'Sibiu', 'Sibiu', '550123', 'Romania'),
('Ana Stan', '0712345685', 'Strada Libertatii 3', 'Oradea', 'Bihor', '410123', 'Romania'),
('George Radu', '0712345686', 'Bulevardul Decebal 8', 'Arad', 'Arad', '310123', 'Romania'),
('Irina Marinescu', '0712345687', 'Strada Garii 12', 'Galati', 'Galati', '800123', 'Romania'),
('Florin Diaconu', '0712345688', 'Strada Stefan cel Mare 30', 'Ploiesti', 'Prahova', '100123', 'Romania'),
('Raluca Stefan', '0712345689', 'Calea Calarasilor 40', 'Braila', 'Braila', '810123', 'Romania'),
('Ioana Gheorghiu', '0712345690', 'Bulevardul Independentei 6', 'Pitesti', 'Arges', '110123', 'Romania'),
('Razvan Tudor', '0712345691', 'Strada Mihai Viteazu 17', 'Suceava', 'Suceava', '720123', 'Romania'),
('Daniela Dobre', '0712345692', 'Calea Bucuresti 21', 'Baia Mare', 'Maramures', '430123', 'Romania'),
('Gabriel Matei', '0712345693', 'Strada Victoriei 11', 'Buzau', 'Buzau', '120123', 'Romania'),
('Adrian Enache', '0712345694', 'Bulevardul Libertatii 14', 'Drobeta-Turnu Severin', 'Mehedinti', '220123', 'Romania'),
('Larisa Dragan', '0712345695', 'Calea Traian 19', 'Alba Iulia', 'Alba', '510123', 'Romania'),
('Vlad Sandu', '0712345696', 'Strada Avram Iancu 22', 'Targu Mures', 'Mures', '540123', 'Romania'),
('Diana Petrescu', '0712345697', 'Bulevardul Eroilor 27', 'Targoviste', 'Dambovita', '130123', 'Romania'),
('Liviu Marinica', '0722252252', 'Aleea Calatis 6', 'Pitesti', 'Arges', '110156', 'Romania');

-- Verificare date introduse in tabel
SELECT * FROM AdresaLivrare;

-- Populare Tabel Adrese Factuare
INSERT INTO AdresaFacturare (cui, adresa, oras, judet, cod_postal, tara) VALUES
('RO123456789', 'Strada Victoriei 10', 'Bucuresti', 'Bucuresti', '010123', 'Romania'),
('RO987654321', 'Bulevardul Unirii 20', 'Cluj-Napoca', 'Cluj', '400123', 'Romania'),
('RO456789123', 'Calea Dorobantilor 15', 'Timisoara', 'Timis', '300123', 'Romania'),
('RO654321987', 'Strada Mare 5', 'Iasi', 'Iasi', '700123', 'Romania'),
('RO321789654', 'Bulevardul Republicii 25', 'Constanta', 'Constanta', '900123', 'Romania'),
('RO789123456', 'Strada Primaverii 7', 'Brasov', 'Brasov', '500123', 'Romania'),
('RO159753486', 'Calea Mosilor 50', 'Sibiu', 'Sibiu', '550123', 'Romania'),
('RO258456789', 'Strada Libertatii 3', 'Oradea', 'Bihor', '410123', 'Romania'),
('RO357159852', 'Bulevardul Decebal 8', 'Arad', 'Arad', '310123', 'Romania'),
('RO456852357', 'Strada Garii 12', 'Galati', 'Galati', '800123', 'Romania'),
(''   , 'Strada Stefan cel Mare 30', 'Ploiesti', 'Prahova', '100123', 'Romania'),
(''   , 'Calea Calarasilor 40', 'Braila', 'Braila', '810123', 'Romania'),
(''   , 'Bulevardul Independentei 6', 'Pitesti', 'Arges', '110123', 'Romania'),
(''   , 'Strada Mihai Viteazu 17', 'Suceava', 'Suceava', '720123', 'Romania'),
(''   , 'Calea Bucuresti 21', 'Baia Mare', 'Maramures', '430123', 'Romania'),
(''   , 'Strada Victoriei 11', 'Buzau', 'Buzau', '120123', 'Romania'),
(''   , 'Bulevardul Libertatii 14', 'Drobeta-Turnu Severin', 'Mehedinti', '220123', 'Romania'),
(''   , 'Calea Traian 19', 'Alba Iulia', 'Alba', '510123', 'Romania'),
(''   , 'Strada Avram Iancu 22', 'Targu Mures', 'Mures', '540123', 'Romania'),
(''   , 'Bulevardul Eroilor 27', 'Targoviste', 'Dambovita', '130123', 'Romania');

-- Verificare date introduse in tabel
SELECT * FROM AdresaFacturare;

INSERT INTO Clienti (id_client, nume, prenume, email, telefon, id_adresa_facturare, id_adresa_livrare) VALUES
(1, 'Popescu', 'Ion', 'ion.popescu@example.com', '0712345678', 1, 1),
(2, 'Ionescu', 'Maria', 'maria.ionescu@example.com', '0712345679', 2, 2),
(3, 'Georgescu', 'Andrei', 'andrei.georgescu@example.com', '0712345680', 3, 3),
(4, 'Dumitrescu', 'Elena', 'elena.dumitrescu@example.com', '0712345681', 4, 4),
(5, 'Vasilescu', 'Mihai', 'mihai.vasilescu@example.com', '0712345682', 5, 5),
(6, 'Nistor', 'Cristina', 'cristina.nistor@example.com', '0712345683', 6, 6),
(7, 'Popa', 'Alexandru', 'alexandru.popa@example.com', '0712345684', 7, 7),
(8, 'Stan', 'Ana', 'ana.stan@example.com', '0712345685', 8, 8),
(9, 'Radu', 'George', 'george.radu@example.com', '0712345686', 9, 9),
(10, 'Marinescu', 'Irina', 'irina.marinescu@example.com', '0712345687', 10, 10),
(11, 'Diaconu', 'Florin', 'florin.diaconu@example.com', '0712345688', 11, 11),
(12, 'Stefan', 'Raluca', 'raluca.stefan@example.com', '0712345689', 12, 12),
(13, 'Gheorghiu', 'Ioana', 'ioana.gheorghiu@example.com', '0712345690', 13, 13),
(14, 'Tudor', 'Razvan', 'razvan.tudor@example.com', '0712345691', 14, 14),
(15, 'Dobre', 'Daniela', 'daniela.dobre@example.com', '0712345692', 15, 15),
(16, 'Matei', 'Gabriel', 'gabriel.matei@example.com', '0712345693', 16, 16),
(17, 'Enache', 'Adrian', 'adrian.enache@example.com', '0712345694', 17, 17),
(18, 'Dragan', 'Larisa', 'larisa.dragan@example.com', '0712345695', 18, 18),
(19, 'Sandu', 'Vlad', 'vlad.sandu@example.com', '0712345696', 19, 19),
(20, 'Petrescu', 'Diana', 'diana.petrescu@example.com', '0712345697', 20, 20);


-- Verificare date introduse in tabel
SELECT * FROM Clienti;

-- Populate Detalii Produse Comanda
INSERT INTO DetaliiProduseComanda (id_comanda, id_intern_produs, cantitate, pret_unitar) VALUES
-- Order 1
(1, 1, 2, 15.99),
(1, 2, 1, 12.99),
(1, 3, 1, 25.99),
-- Order 2
(2, 4, 3, 18.99),
(2, 5, 2, 9.99),
-- Order 3
(3, 6, 1, 35.99),
(3, 7, 1, 14.99),
-- Order 4
(4, 8, 5, 19.99),
-- Order 5
(5, 1, 1, 15.99),
(5, 6, 2, 35.99),
(5, 8, 1, 19.99),
-- Order 6
(6, 2, 2, 12.99),
(6, 5, 3, 9.99),
-- Order 7
(7, 4, 1, 18.99),
(7, 7, 2, 14.99),
-- Order 8
(8, 3, 1, 25.99),
(8, 6, 1, 35.99),
(8, 8, 2, 19.99),
-- Order 9
(9, 1, 3, 15.99),
(9, 5, 2, 9.99),
(9, 8, 1, 19.99),
-- Order 10
(10, 2, 1, 12.99),
(10, 6, 1, 35.99),
(10, 7, 2, 14.99),
-- Order 11
(11, 1, 1, 15.99),  -- Lipstick Buze - Rosu
(11, 2, 2, 12.99),  -- Mascara Gene- Negru Mat
(11, 3, 1, 25.99),  -- Foundation Ochi - Ten deschis
-- Order 12
(12, 4, 2, 18.99),  -- Blush Pudra- Roz
(12, 5, 3, 9.99),   -- Eyeliner Ochi- Maro
(12, 6, 1, 35.99),  -- Paleta Ochi - Nude
-- Order 13
(13, 7, 1, 14.99),  -- Concealer - Medium
(13, 8, 2, 19.99),  -- Highlighter - Stralucitor
-- Order 14
(14, 1, 3, 15.99),  -- Lipstick Buze - Rosu
(14, 3, 1, 25.99),  -- Foundation Ochi - Ten deschis
(14, 6, 1, 35.99),  -- Paleta Ochi - Nude
-- Order 15
(15, 2, 1, 12.99),  -- Mascara Gene- Negru Mat
(15, 4, 2, 18.99),  -- Blush Pudra- Roz
(15, 5, 2, 9.99),   -- Eyeliner Ochi- Maro
-- Order 16
(16, 7, 1, 14.99),  -- Concealer - Medium
(16, 8, 2, 19.99),  -- Highlighter - Stralucitor
-- Order 17
(17, 1, 2, 15.99),  -- Lipstick Buze - Rosu
(17, 2, 1, 12.99),  -- Mascara Gene- Negru Mat
(17, 5, 3, 9.99),   -- Eyeliner Ochi- Maro
-- Order 18
(18, 3, 1, 25.99),  -- Foundation Ochi - Ten deschis
(18, 6, 1, 35.99),  -- Paleta Ochi - Nude
(18, 8, 2, 19.99),  -- Highlighter - Stralucitor
-- Order 19
(19, 2, 2, 12.99),  -- Mascara Gene- Negru Mat
(19, 4, 1, 18.99),  -- Blush Pudra- Roz
(19, 5, 2, 9.99),   -- Eyeliner Ochi- Maro
-- Order 20
(20, 3, 2, 25.99),  -- Foundation Ochi - Ten deschis
(20, 6, 1, 35.99),  -- Paleta Ochi - Nude
(20, 7, 1, 14.99);  -- Concealer - Medium

-- Verificare date introduse in tabel
SELECT * FROM DetaliiProduseComanda;

-- Populare Tabel Comenzi
INSERT INTO Comezi (numar_comanda, id_client, curier, data_livrare, tip_plata) VALUES
('KS456784', 1, 'FAN', '2024-08-10', 'card'),
('KS456785', 2, 'SameDay', '2024-08-11', 'cash'),
('KS456786', 3, 'Cargus', '2024-08-12', 'card'),
('KS456787', 4, 'DHL', '2024-08-13', 'cash'),
('KS456788', 5, 'FAN', '2024-08-14', 'card'),
('KS456789', 6, 'SameDay', '2024-08-15', 'card'),
('KS456790', 7, 'Cargus', '2024-08-16', 'cash'),
('KS456791', 8, 'DHL', '2024-08-17', 'card'),
('KS456792', 9, 'FAN', '2024-08-18', 'cash'),
('KS456793', 10, 'SameDay', '2024-08-19', 'card'),
('KS456794', 11, 'Cargus', '2024-08-20', 'cash'),
('KS456795', 12, 'DHL', '2024-08-21', 'card'),
('KS456796', 13, 'FAN', '2024-08-22', 'cash'),
('KS456797', 14, 'SameDay', '2024-08-23', 'card'),
('KS456798', 15, 'Cargus', '2024-08-24', 'cash'),
('KS456799', 16, 'DHL', '2024-08-25', 'card'),
('KS456800', 17, 'FAN', '2024-08-26', 'cash'),
('KS456801', 18, 'SameDay', '2024-08-27', 'card'),
('KS456802', 19, 'Cargus', '2024-08-28', 'cash'),
('KS456803', 20, 'DHL', '2024-08-29', 'card');

-- Verificare date introduse in tabel
SELECT * FROM Comezi;

-- Adaugare camp nou in comada pentru calcularea sumei totala de plata
ALTER TABLE Comezi
ADD COLUMN suma_totala DECIMAL(10, 2);

-- Actualizare camp suma de plata bazat pe informatiile din tabelul DetaliiProduseComanda
UPDATE Comezi c
JOIN (
    SELECT 
        id_comanda,
        SUM(cantitate * pret_unitar) AS suma_totala
    FROM 
        DetaliiProduseComanda
    GROUP BY 
        id_comanda
) dc ON c.id_comanda = dc.id_comanda
SET c.suma_totala = dc.suma_totala;

-- Afisare toate campurile din AdresaLivrare cu oras destinatie Pitesti
SELECT *
FROM AdresaLivrare
WHERE oras = 'Pitesti';

-- Afisare toate fetele (generalizare prin care toate fetele au prenumele terminat in litera a)
SELECT nume, prenume, telefon
FROM Clienti
WHERE prenume LIKE '%a'
ORDER BY nume, prenume;

SELECT * FROM Clienti;
SELECT * FROM Produse;
SELECT * FROM DetaliiProduseComanda;

-- Afisare clienti cu nume, prenume, numar comanda si suma toatala acolo unde suma totala 
-- este mai mare strict decat 100    
SELECT
    cl.nume,
    cl.prenume,
    c.numar_comanda,
    c.suma_totala
FROM
    Clienti cl
INNER JOIN
    Comezi c ON cl.id_client = c.id_client
WHERE
    c.suma_totala > 100;
    
SELECT * FROM Clienti;
SELECT * FROM Comezi;

-- Afisarea comezilor cu id, numar comanda, nume client, prenume si suma toatala acolo 
-- unde id_client din Clienti (cheie primara) este egal cu id_client din Comenzi (cheie secundara)
SELECT
    c.id_comanda,
    c.numar_comanda,
    cl.nume,
    cl.prenume,
    c.suma_totala
FROM
    Comezi c
LEFT JOIN
    Clienti cl ON c.id_client = cl.id_client;
    
-- Afisarea tuturor comezilor cu id si nr comada, numele producator, canitate si pret unitar pentru
-- produsele cu pret mai mare de 10 lei si aflate la locatia cu id 1001 ori cu id_comanda null dupa
-- RIGHT JOIN    
SELECT
    c.id_comanda,
    c.numar_comanda,
    p.nume_producator,
    dpc.cantitate,
    dpc.pret_unitar
FROM
    DetaliiProduseComanda dpc
RIGHT JOIN
    Comezi c ON dpc.id_comanda = c.id_comanda
RIGHT JOIN
    Produse p ON dpc.id_intern_produs = p.id_intern_produs
WHERE
    (p.pret_unitar > 10 AND p.id_locatie = 1001)
    OR dpc.id_comanda IS NULL;

-- Primii 10 clienti ordonati dupa nume crescator cu afisare id, nume, prenume, email
SELECT
    id_client,
    nume,
    prenume,
    email
FROM
    Clienti
ORDER BY
    nume ASC
LIMIT 10;

-- Primele 5 sume de plata afisate descrescator
SELECT
    id_comanda,
    numar_comanda,
    suma_totala
FROM
    Comezi
ORDER BY
    suma_totala DESC
LIMIT 5;

-- Am vazut un typo in numele tabelului Comenzi, care s-a creat de fapt cu numele Comezi
-- Actualizare nume tabel
RENAME TABLE Comezi TO Comenzi;

-- Afisare Tabele pentru verificare
SHOW TABLES;
