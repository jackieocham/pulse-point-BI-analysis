/* Pulse Point BI Analysis by Jacqueline Chambers
Data preparation steps:
    - edit table field names
    - change FALSE values to 0 AND TRUE values to 1 in boolean fields
    - change format of date to match data type format
    - edit table data types
    - verify no redundancies
    - create calculated field "Client_Lifetime" in "clients" table
    - create caluclated field "Service_ID" for categorical coding in "clients" table
    */

-- THE DATA --
    
SELECT *
FROM clients;

SELECT *
FROM contacts;

SELECT *
FROM transactions;

SET SQL_SAFE_UPDATES = 0; /* Turn off safe mode to update table. Tables are backed in case need to revert. */

-- EDIT FIELD NAMES --

ALTER TABLE clients
RENAME COLUMN ï»¿ID TO ID;
ALTER TABLE clients
RENAME COLUMN `Directory` TO Directory_Name;

ALTER TABLE contacts
RENAME COLUMN ï»¿ID TO ID,
RENAME COLUMN `Name` TO Full_Name,
RENAME COLUMN `Client` TO Clientele,
RENAME COLUMN `Address Line 1` TO Address_1,
RENAME COLUMN `Address Line 2` TO Address_2,
RENAME COLUMN `Zip Code` TO Zip_Code;

ALTER TABLE transactions
RENAME COLUMN ï»¿ID TO ID,
RENAME COLUMN `DATE` TO Service_Date,
RENAME COLUMN `Service Completed` TO Completed,
RENAME COLUMN `Employment Type` TO Employment,
RENAME COLUMN `Service Type` TO Category,
RENAME COLUMN `Service Description` TO Service;

-- EDIT FIELDS TO CORRECT FORMAT FOR DATATYPE --

-- Clients
UPDATE clients
SET Business = IF(
Business = "TRUE", 1, 0);

UPDATE clients
SET Private_Client = IF(
Private_Client = "TRUE", 1, 0);

UPDATE clients
SET Gym_Client = IF(
Gym_Client = "TRUE", 1, 0);

UPDATE clients
SET Repeat_Cust = IF(
Repeat_Cust = "TRUE", 1, 0);

UPDATE clients
SET Repeat_Client = IF(
Repeat_Client = "TRUE", 1, 0);

UPDATE clients
SET Start_Date = STR_TO_DATE(Start_Date,"%d-%b-%y");

UPDATE clients
SET End_Date = STR_TO_DATE(End_Date,"%d-%b-%y");

UPDATE clients
SET Referral_ID = IF(
Referral_ID = "", null, Referral_ID);

UPDATE clients
SET Directory_Name = IF(
Directory_Name = "", null, Directory_Name);

UPDATE clients
SET Age = IF(
Age = "", null, Age);

UPDATE clients
SET Notes = IF(
Notes = "", null, Notes);

UPDATE clients
SET Age = IF(
Business = 1, -1, Age);

SELECT *
FROM clients;

-- Contacts
UPDATE contacts
SET Clientele = IF(
Clientele = "TRUE", 1, 0);

SELECT *
FROM contacts;

-- Transactions
UPDATE transactions
SET Service_Date = STR_TO_DATE(Service_Date,"%m/%e/%y %l:%i %p");

UPDATE transactions
SET Revenue = SUBSTRING_INDEX(Revenue, "$", -1);

UPDATE transactions
SET Paid = IF(
Paid = "TRUE", 1, 0);

UPDATE transactions
SET Completed = IF(
Completed = "TRUE", 1, 0);

SELECT *
FROM transactions;

-- CHANGE FIELD DATA TYPES --
ALTER TABLE clients MODIFY Contact_ID text;
ALTER TABLE clients MODIFY Business bool;
ALTER TABLE clients MODIFY Private_Client bool;
ALTER TABLE clients MODIFY Gym_Client bool;
ALTER TABLE clients MODIFY Repeat_Cust bool;
ALTER TABLE clients MODIFY Start_Date date;
ALTER TABLE clients MODIFY End_Date date;
ALTER TABLE clients MODIFY Age int;

SELECT *
FROM clients;

ALTER TABLE contacts MODIFY Clientele bool;

SELECT *
FROM contacts;

ALTER TABLE transactions MODIFY Service_Date datetime;
ALTER TABLE transactions MODIFY Revenue dec(10, 2);

SELECT *
FROM transactions;

-- VERIFY/VALIDATE DATA --

-- Edit "Private_Client" field for accuracy.
UPDATE clients
SET Private_Client = IF(
Business = 1, 1, Private_Client);

UPDATE clients
SET Private_Client = 0 
WHERE ID = 53 OR ID = 54 OR ID = 66;

-- Clients
-- Contacts
-- Transactions

-- CREATE CALCULATED FIELDS --

-- Client Lifetime

-- Service ID: to assign numerical value to categorical data