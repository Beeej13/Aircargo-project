CREATE DATABASE AIRCARGO;

USE AIRCARGO;


SELECT ROUTE_ID, FLIGHT_NUM, ORIGIN_AIRPORT, DESTINATION_AIRPORT, AIRCRAFT_ID, DISTANCE_MILES
  FROM ROUTES;
  
-- Display passage who travelled routes 01-25

SELECT CUSTOMER_ID
  FROM PASSENGERS_ON_FLIGHTS
 WHERE ROUTE_ID BETWEEN 01 AND 25;
 
-- Display # of passengers and total revenue in business class

SELECT COUNT(CUSTOMER_ID) AS NUMBER_OF_PASSENGERS, SUM(PRICE_PER_TICKET)
  FROM TICKET_DETAILS
 WHERE CLASS_ID = 'BUSSINESS';
 
-- Display customer name 
 
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS CUSTOMER_NAME
  FROM CUSTOMER;
  
-- Extract customers who have registered and booked a ticket from two tables using joins

SELECT C.FIRST_NAME, C.LAST_NAME 
  FROM CUSTOMER C
  JOIN TICKET_DETAILS T
    ON C.CUSTOMER_ID=T.CUSTOMER_ID;
    
-- Extract customer based on their customer ID and brand (Emirates)

SELECT FIRST_NAME, LAST_NAME
  FROM CUSTOMER
 WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID
		  FROM TICKET_DETAILS
		 WHERE BRAND = 'EMIRATES');
         
-- List passengers flying economy using 'Having' and 'Group By' clause

SELECT CUSTOMER_ID
  FROM PASSENGERS_ON_FLIGHTS
 GROUP BY CLASS_ID
 HAVING CLASS_ID LIKE 'ECONOMY';
 
-- Identify whether the revenue has crossed 10000 using the IF clause 
 
SELECT SUM(PRICE_PER_TICKET * NO_OF_TICKETS) AS 'REVENUE', IF ('REVENUE' > 10000,'NO','YES') AS ANSWER
  FROM TICKET_DETAILS;
  
-- Creating a user (John Smith) and granting them access to database (aircargo)

CREATE USER '{J.Smith}'@'{hostname}' IDENTIFIED BY '{SmithJohn}';

GRANT ALL PRIVILEGES ON aircargo TO 'J.Smith'@'hostname' WITH GRANT OPTION;

-- Find maximum ticket price for each class using window fucntions

SELECT RANK() OVER (ORDER BY PRICE_PER_TICKET DESC) AS 'RANK', CLASS_ID, PRICE_PER_TICKET
  FROM TICKET_DETAILS
 GROUP BY CLASS_ID
 ORDER BY 'RANK' ASC;
 
-- Improving speed and performance of extracting passengers with route_ID of 4

EXPLAIN SELECT *
		  FROM PASSENGERS_ON_FLIGHTS
		 WHERE ROUTE_ID = 4;
         
CREATE INDEX PASS_R_4 ON PASSENGERS_ON_FLIGHTS(ROUTE_ID);
-- DROP INDEX PASS_R_4

-- Calculate total price of all tickets using ROLLUP function

SELECT SUM(PRICE_PER_TICKET) TOTAL, CUSTOMER_ID, AIRCRAFT_ID
  FROM TICKET_DETAILS
 GROUP BY AIRCRAFT_ID WITH ROLLUP
 ORDER BY TOTAL DESC;
 
-- Creating a view with business classes and their airline

CREATE VIEW BUSINESS_AIRLINES AS
SELECT CLASS_ID, BRAND
  FROM TICKET_DETAILS 
 WHERE CLASS_ID = 'BUSSINESS';
 
SELECT * 
  FROM BUSINESS_AIRLINES;
  
-- Stored procedure to extract details where flight distance is > 2000
-- Check stored procedures


