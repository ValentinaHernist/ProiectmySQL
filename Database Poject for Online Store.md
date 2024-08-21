<h1> Database Project for **KissAndMakeUp Online Store** </h1>
The scope of this project is to use all the SQL knowledge gained throughout the Software Testing course and apply it in practice.

Application under test: KissAndMakeUp

Tools used: MySQL Workbench

Database description: The database contains tables necessary for the management of an online store with the role of helping the development of the store and being useful to the employees in the delivery, support, or financial departments.

<ol>
<li> Database Schema </li>
<br>   
   You can find below the database schema that was generated through Reverse Engineering a basic online store and which contains all the tables and the relationships between them.
The tables are connected in the following way:

   <ul>
   <li>a) Depozit (1) -> Produse (N) </li>
   <li>b) Clienti (1) -> Comenzi (N) </li>
   <li>c) Comenzi (1) -> DetaliiProduseComanda (N) </li>
   <li>d) Produse (1) -> DetaliiProduseComanda (N) </li>
   <li>e) Clienti (1) -> AdresaFacturare (1) </li>
   <li>f) Clienti (1) -> AdresaLivrare (1) </li>
   </ul> <br>
<li>Database Queries</li><br>
<ol type="a">
    <li>Database Queries can be observed here: https://github.com/ValentinaHernist/ProiectmySQL/blob/main/ProiectmySQL.sql, but I will also summarize some commands here:</li>
   <br>
     1. DDL (Data Definition Language): <br>
      The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS): <br>
      - CREATE DATABASE KissAndMakeup <br>
      - CREATE TABLE Depozit <br>
      - CREATE TABLE Produse <br>
      - CREATE TABLE AdresaFacturare <br>
      - CREATE TABLE AdresaLivrare <br>
      - CREATE TABLE Clienti <br>
      - CREATE TABLE Comenzi <br>
	  - CREATE TABLE DetaliiProduseComanda <br>
	  After all tables were created, I changed the name of a column in the table Depozit <br>
      ALTER TABLE Depozit CHANGE tip_impachetare tip_stocare  VARCHAR(100); <br>
	  And added a new field into Produse, the UNIQUE type cod_bare <br>
	  ALTER TABLE Produse ADD cod_bare VARCHAR(13) UNIQUE; <br>
   <br>
     2. DML (Data Manipulation Language): <br>
       To perform some queries in the database tables, I populated the tables using the INSERT command <br>
       - INSERT INTO '<table_name>' <br>
sql
Copy code
  <br>
   After the INSERT command, I calculated the total sum of orders automatically using the UPDATE command <br>
      ALTER TABLE Comenzi
      ADD COLUMN suma_totala DECIMAL(10, 2);

       UPDATE Comenzi c <br>
        JOIN ( <br>
            SELECT <br>
               id_comanda, <br>
               SUM(cantitate * pret_unitar) AS suma_totala <br>
            FROM <br> 
               DetaliiProduseComanda <br>
            GROUP BY <br>
               id_comanda <br>
        ) dc ON c.id_comanda = dc.id_comanda<br>
        SET c.suma_totala = dc.suma_totala; <br>

  3. DQL (Data Query Language): <br>
  To simulate a use case from different departments:  <br>
   - SELECT * FROM AdresaLivrare WHERE oras = 'Pitesti'; - **Display** all fields from AdresaLivrare with destination city Pitesti<br>
   - SELECT nume, prenume, telefon  FROM Clienti WHERE prenume LIKE '%a' ORDER BY nume, prenume; - Display all females (generalization where all females have first names ending in the letter 'a')<br>
<br>
       - JOINS: <br>
   <br>
       a) INNER JOIN between Clienti and Comenzi <br>
       Explanation: <br>
       Clienti: The table containing information about all online store clients. <br>
       Comenzi: The table containing information about all orders. <br>
       INNER JOIN: This operation matches records from both tables, Clienti and Comenzi, based on the Clienti.id_client <br>
   <br>
       **The Business Purpose** of this JOIN: This query is designed to retrieve information about clients who have placed orders with a total amount (`suma_totala`) greater than 100, **in order** to offer a discount **on** their next orders. <br>
       <br>
       b) LEFT JOIN between Clienti and Comenzi <br>
       Explanation: <br>
       **Clienti**: The table containing information about all online store clients. - the main table <br>
       **Comenzi**: The table containing information about all orders. - the left table in the join <br>
       **LEFT JOIN**: Returns all rows in the Comenzi table, even if there is no match in the Clienti table. <br>
   <br>
       **The Business Purpose** of this JOIN: This can help customer support employees to check the linkage between names and AWB (Air Waybill), expedition company, when performing a client check call. <br>
       <br>
       c) RIGHT JOIN between Comenzi, Produse, and DetaliiProduseComanda <br>
       Explanation: <br>
       **Comenzi**: The secondary table in the first RIGHT JOIN query, containing information about orders. <br>
       **Produse**: The primary table in the second query, containing information about all products. <br>
       **DetaliiProduseComanda** is the primary table in the first RIGHT JOIN, containing details about orders. <br> 
       **RIGHT JOIN**: The query returns all rows from the Comenzi table, regardless of whether there is a matching row in the DetaliiProduseComanda table. If a Comenzi row does not have a matching `id_comanda` in DetaliiProduseComanda, the columns from DetaliiProduseComanda (like `cantitate` and `pret_unitar`) will be `NULL`.
       The second join returns all rows from the Produse table, regardless of whether there is a matching row in the result of the previous join (which now includes both Comenzi and DetaliiProduseComanda).<br>
   <br>
       **The Business Purpose** of this JOIN: Obtain statistics about orders and clients for the marketing department.<br>
       <br>
       - LIMITS; <br>
       - ORDER BY; <br>
       - Subqueries <br>
</ol>
<br>
<li>Conclusions</li>
In summary, I’ve developed a robust MySQL database that effectively manages data and ensures seamless operations for all members of the online store. This setup is designed to handle the needs of the online store while being flexible enough to accommodate future growth and changes in the organization.

</ol>