# Database Project for **KissAndMakeUp Online Store**

The scope of this project is to use all the SQL knowledge gained throughout the Software Testing course and apply it in practice.

**Application under test:** KissAndMakeUp

**Tools used:** MySQL Workbench

**Database description:** The database contains tables necessary for the management of an online store with the role of helping the development of the store and being useful to the employees in the delivery, support, or financial departments.

1. **Database Schema**

   You can find below the database schema that was generated through Reverse Engineering a basic online store and which contains all the tables and the relationships between them.
   The tables are connected in the following way:

   - a) Depozit (1) -> Produse (N)
   - b) Clienti (1) -> Comenzi (N)
   - c) Comenzi (1) -> DetaliiProduseComanda (N)
   - d) Produse (1) -> DetaliiProduseComanda (N)
   - e) Clienti (1) -> AdresaFacturare (1)
   - f) Clienti (1) -> AdresaLivrare (1)

2. **Database Queries**

   Database Queries can be observed here: [GitHub - ProiectmySQL.sql](https://github.com/ValentinaHernist/ProiectmySQL/blob/main/ProiectmySQL.sql), but I will also summarize some commands here:

   a. **DDL (Data Definition Language):**
      
      The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS):
      ```sql
      CREATE DATABASE KissAndMakeup;
      CREATE TABLE Depozit;
      CREATE TABLE Produse;
      CREATE TABLE AdresaFacturare;
      CREATE TABLE AdresaLivrare;
      CREATE TABLE Clienti;
      CREATE TABLE Comenzi;
      CREATE TABLE DetaliiProduseComanda;
      ```

      After all tables were created, I changed the name of a column in the table Depozit
      ```sql
      ALTER TABLE Depozit CHANGE tip_impachetare tip_stocare VARCHAR(100);
      ```

      And added a new field into Produse, the UNIQUE type cod_bare
      ```sql
      ALTER TABLE Produse ADD cod_bare VARCHAR(13) UNIQUE;
      ```

   b. **DML (Data Manipulation Language):**
      
      To perform some queries in the database tables, I populated the tables using the INSERT command
      ```sql
      INSERT INTO `<table_name>`;
      ```

      After the INSERT command, I calculated the total sum of orders automatically using the UPDATE command
      ```sql
      ALTER TABLE Comenzi 
      ADD COLUMN suma_totala DECIMAL(10, 2); 
      
      UPDATE Comenzi c 
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
      ```

   c. **DQL (Data Query Language):**
      
      To simulate a use case from different departments:
      ```sql
      SELECT * FROM AdresaLivrare WHERE oras = 'Pitesti'; 
      -- Display all fields from AdresaLivrare with destination city Pitesti
      
      SELECT nume, prenume, telefon FROM Clienti WHERE prenume LIKE '%a' ORDER BY nume, prenume; 
      -- Display all females (generalization where all females have first names ending in the letter 'a')
      ```

      **JOINS:**

      - a) INNER JOIN between Clienti and Comenzi

        **Explanation:**
        - **Clienti:** The table containing information about all online store clients.
        - **Comenzi:** The table containing information about all orders.
        - **INNER JOIN:** This operation matches records from both tables, Clienti and Comenzi, based on the Clienti.id_client.

        **The Business Purpose** of this JOIN: This query is designed to retrieve information about clients who have placed orders with a total amount (`suma_totala`) greater than 100, in order to offer a discount on their next orders.

      - b) LEFT JOIN between Clienti and Comenzi

        **Explanation:**
        - **Clienti:** The table containing information about all online store clients - the main table.
        - **Comenzi:** The table containing information about all orders - the left table in the join.
        - **LEFT JOIN:** Returns all rows in the Comenzi table, even if there is no match in the Clienti table.

        **The Business Purpose** of this JOIN: This can help customer support employees to check the linkage between names and AWB (Air Waybill), expedition company, when performing a client check call.

      - c) RIGHT JOIN between Comenzi, Produse, and DetaliiProduseComanda

        **Explanation:**
        - **Comenzi:** The secondary table in the first RIGHT JOIN query, containing information about orders.
        - **Produse:** The primary table in the second query, containing information about all products.
        - **DetaliiProduseComanda:** The primary table in the first RIGHT JOIN, containing details about orders.
        - **RIGHT JOIN:** The query returns all rows from the Comenzi table, regardless of whether there is a matching row in the DetaliiProduseComanda table. If a Comenzi row does not have a matching `id_comanda` in DetaliiProduseComanda, the columns from DetaliiProduseComanda (like `cantitate` and `pret_unitar`) will be `NULL`. The second join returns all rows from the Produse table, regardless of whether there is a matching row in the result of the previous join (which now includes both Comenzi and DetaliiProduseComanda).

        **The Business Purpose** of this JOIN: Obtain statistics about orders and clients for the marketing department.

      - **LIMITS:**
      - **ORDER BY:**
      - **Subqueries:**

3. **Conclusions**

   In summary, I’ve developed a robust MySQL database that effectively manages data and ensures seamless operations for all members of the online store. This setup is designed to handle the needs of the online store while being flexible enough to accommodate future growth and changes in the organization.

