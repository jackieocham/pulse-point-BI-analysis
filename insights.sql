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

-- Total Revenue: $26153.27
SELECT SUM(Revenue) AS TotalRev
FROM transactions;

-- Yearly Revenue
SELECT SUM(Revenue) AS Rev2015
FROM transactions
WHERE YEAR(Service_Date) = 2015;

SELECT SUM(Revenue) AS Rev2016
FROM transactions
WHERE YEAR(Service_Date) = 2016;

SELECT SUM(Revenue) AS Rev2017
FROM transactions
WHERE YEAR(Service_Date) = 2017;

SELECT SUM(Revenue) AS Rev2018
FROM transactions
WHERE YEAR(Service_Date) = 2018;

SELECT SUM(Revenue) AS Rev2019
FROM transactions
WHERE YEAR(Service_Date) = 2019;

-- Revenue Per Client
SELECT SUM()