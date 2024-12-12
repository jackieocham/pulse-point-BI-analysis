/* Pulse Point BI Analysis by Jacqueline Chambers

How well did I run my business when I was working self-employed? This project aims to not only estimate the answer that question, but to solidify technical, analytical and communication skills I aspire to use in my career. */

-- THE DATA --

SELECT *
FROM business_analysis.clients;

SELECT *
FROM business_analysis.contacts;

SELECT *
FROM business_analysis.transactions;

-- FINANCIAL ANALYSIS --

/* Total Revenue: TotalRev = $21,653.27 */
SELECT SUM(Revenue) AS TotalRev
FROM transactions
WHERE Employment = "self-employed";

/* Yearly Revenue: I used 2 methods. The first method is clunky. The second method graceful.
Rev2015 = $510.00 
Rev2016 = $3,594.98
Rev2017 = $6,226.14
Rev2018 = $3,521.35
Rev2019 = $3,208.50
Rev2020 = $2,664.00
Rev2021 = $1,928.30
*/

-- METHOD 1: clunky
SELECT SUM(Revenue) AS Rev2015
FROM transactions
WHERE YEAR(Service_Date) = 2015
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2016
FROM transactions
WHERE YEAR(Service_Date) = 2016
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2017
FROM transactions
WHERE YEAR(Service_Date) = 2017
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2018
FROM transactions
WHERE YEAR(Service_Date) = 2018
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2019
FROM transactions
WHERE YEAR(Service_Date) = 2019
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2020
FROM transactions
WHERE YEAR(Service_Date) = 2020
AND Employment = "self-employed";

SELECT SUM(Revenue) AS Rev2021
FROM transactions
WHERE YEAR(Service_Date) = 2021
AND Employment = "self-employed";

-- Method 2: More efficient and elegant
SELECT YEAR(Service_Date) AS `Year`, SUM(Revenue) AS Revenue
FROM transactions
WHERE Employment = "self-employed"
GROUP BY YEAR(Service_Date)
ORDER BY YEAR(Service_Date) ASC;

-- Revenue Per Client
/* 1. Join clients table to transactions table using a LEFT JOIN on Client_ID and ID. */
SELECT *
FROM transactions
LEFT JOIN clients
ON transactions.Client_ID = clients.ID;

SELECT *
FROM clients;

SELECT *
FROM transactions;

-- Client Satisfaction Measurement/Repeat Clients --

-- Repeat Private Clients: 18 repeat customer
SELECT COUNT(Repeat_Cust)
FROM clients
WHERE Repeat_Cust = 1 AND Gym_Client = 0;

SELECT *
FROM clients;

-- Total Private Clients: 24
SELECT COUNT(ID)
FROM clients
WHERE Private_Client = 1;

SELECT *
FROM clients;

-- Percentage of Repeat Private Clients: 75% ((18/24)*100)
SELECT COUNT(Repeat_Cust)/(SELECT COUNT(ID)
FROM clients
WHERE Private_Client = 1)*100
FROM clients
WHERE Repeat_Cust = 1 AND Gym_Client = 0;

SELECT *
FROM clients;

-- Number of transactions per client --
SELECT Client_Name, COUNT(Client_ID)
FROM transactions
GROUP BY Client_ID, Client_Name
ORDER BY COUNT(Client_ID);

SELECT *
FROM transactions;
