-- MySQL

-- ECS519U Coursework 3 (Suspicious activities), MySQL script
  
-- Alzain Alawadhi 220967288 <a.alawadhi@se22.qmul.ac.uk>
-- Layan Alassaf 230874145 <l.alassaf@stu22.qmul.ac.uk>
-- Mohammed Akbar Ali 230097939 <m.ali@se23.qmul.ac.uk>

-- Create database and clear any existing data
DROP DATABASE IF EXISTS `SuspiciousActivities`;
CREATE DATABASE `SuspiciousActivities`;
USE `SuspiciousActivities`;
DROP TABLE IF EXISTS Entity;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Person_Event;
DROP TABLE IF EXISTS SuspiciousActivityReport;

-- Part 1: database creation

-- Create tables
CREATE TABLE Entity (
    EntityID INT PRIMARY KEY AUTO_INCREMENT,
    EntityType VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Status VARCHAR(50)
);

CREATE TABLE Person (
    PersonID INT PRIMARY KEY AUTO_INCREMENT,
    EntityID INT,
    Forename VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Nationality VARCHAR(50),
    FOREIGN KEY (EntityID) REFERENCES Entity(EntityID)
);

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    EntityID INT,
    Name VARCHAR(100) NOT NULL,
    Industry VARCHAR(100),
    Country VARCHAR(50) NOT NULL,
    FOREIGN KEY (EntityID) REFERENCES Entity(EntityID)
);

CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    PersonID INT,
    CompanyID INT,
    TransactionDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    SuspiciousLevel INT CHECK (SuspiciousLevel BETWEEN 1 AND 5) DEFAULT 1,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

CREATE TABLE Property (
    PropertyID INT PRIMARY KEY AUTO_INCREMENT,
    OwnerID INT NOT NULL,
    Location VARCHAR(200) NOT NULL,
    Value DECIMAL(15,2) NOT NULL,
    SuspiciousLevel INT CHECK (SuspiciousLevel BETWEEN 1 AND 5) DEFAULT 1,
    FOREIGN KEY (OwnerID) REFERENCES Person(PersonID)
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(100) NOT NULL,
    Location VARCHAR(200) NOT NULL,
    Date DATE NOT NULL,
    SuspiciousLevel INT CHECK (SuspiciousLevel BETWEEN 1 AND 5) DEFAULT 1
);

CREATE TABLE Person_Event (
    PersonID INT,
    EventID INT,
    PRIMARY KEY (PersonID, EventID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE SuspiciousActivityReport (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    ReportDate DATE NOT NULL,
    Institution VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Description TEXT,
    PersonID INT,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Insert data
INSERT INTO Entity (EntityType, Name, Status) VALUES
('Person', 'John Smith', 'Active'),
('Person', 'Emily Johnson', 'Flagged'),
('Person', 'Michael Chen', 'Suspended'),
('Person', 'Sarah Rodriguez', 'Active'),
('Person', 'Alexander Petrov', 'Under Investigation'),
('Person', 'Aisha Mohammed', 'Active'),
('Person', 'Carlos Fernandez', 'Active'),
('Person', 'Wei Zhang', 'Suspended'),
('Person', 'Elena Kovacs', 'Flagged'),
('Person', 'Omar Hassan', 'Under Investigation'),
('Person', 'Maria Silva', 'Under Monitoring'),
('Person', 'Raj Patel', 'Under Review'),
('Person', 'Sophia Kim', 'Flagged'),
('Person', 'Diego Morales', 'Flagged'),
('Person', 'Natalia Ivanova', 'Active'),
('Company', 'GlobalTech Solutions', 'Active'),
('Company', 'Offshore Investments Inc', 'Active'),
('Company', 'Quantum Dynamics', 'Active'),
('Company', 'Crypto Innovations Ltd', 'Active'),
('Company', 'Eastern European Traders', 'Active'),
('Company', 'Middle East Energy Corp', 'Active'),
('Company', 'Latin American Investments', 'Active'),
('Company', 'TechHub Enterprises', 'Active'),
('Company', 'Global Logistics Inc', 'Active'),
('Company', 'Asian Pacific Bank', 'Active'),
('Company', 'Green Energy Solutions', 'Active'),
('Company', 'Pharma Innovations', 'Active'),
('Company', 'Continental Mining', 'Active'),
('Company', 'Digital Media Group', 'Active'),
('Company', 'Global Agricultural Traders', 'Active');

INSERT INTO Person (EntityID, Forename, Surname, DOB, Nationality) VALUES
(1, 'John', 'Smith', '1974-12-03', 'United Kingdom'),
(2, 'Emily', 'Johnson', '2001-08-19', 'United States of America'),
(3, 'Michael', 'Chen', '1995-02-25', 'Canada'),
(4, 'Sarah', 'Rodriguez', '1987-07-13', 'Spain'),
(5, 'Alexander', 'Petrov', '1976-10-05', 'Russia'),
(6, 'Aisha', 'Mohammed', '2003-03-29', 'United Arab Emirates'),
(7, 'Carlos', 'Fernandez', '1980-09-11', 'Brazil'),
(8, 'Wei', 'Zhang', '2005-11-22', 'China'),
(9, 'Elena', 'Kovacs', '1999-04-18', 'Hungary'),
(10, 'Omar', 'Hassan', '2008-07-09', 'Egypt'),
(11, 'Maria', 'Silva', '1985-01-16', 'Portugal'),
(12, 'Raj', 'Patel', '2002-10-03', 'India'),
(13, 'Sophia', 'Kim', '2011-06-25', 'South Korea'),
(14, 'Diego', 'Morales', '1998-02-12', 'Mexico'),
(15, 'Natalia', 'Ivanova', '1989-05-08', 'Ukraine');

INSERT INTO Company (EntityID, Name, Industry, Country) VALUES
(16, 'GlobalTech Solutions', 'Technology', 'United States of America'),
(17, 'Offshore Investments Inc', 'Financial Services', 'Cayman Islands'),
(18, 'Quantum Dynamics', 'Research', 'Singapore'),
(19, 'Crypto Innovations Ltd', 'Cryptocurrency', 'Malta'),
(20, 'Eastern European Traders', 'International Trade', 'Estonia'),
(21, 'Middle East Energy Corp', 'Energy', 'Qatar'),
(22, 'Latin American Investments', 'Investment', 'Panama'),
(23, 'TechHub Enterprises', 'Software Development', 'Israel'),
(24, 'Global Logistics Inc', 'Shipping', 'Netherlands'),
(25, 'Asian Pacific Bank', 'Banking', 'Hong Kong'),
(26, 'Green Energy Solutions', 'Renewable Energy', 'Germany'),
(27, 'Pharma Innovations', 'Pharmaceutical', 'Switzerland'),
(28, 'Continental Mining', 'Natural Resources', 'Australia'),
(29, 'Digital Media Group', 'Media', 'United Kingdom'),
(30, 'Global Agricultural Traders', 'Agriculture', 'Brazil');

INSERT INTO Transaction (PersonID, CompanyID, TransactionDate, Amount, Type, SuspiciousLevel) VALUES
(3, 1, '2015-05-15', 250000.00, 'Stock Purchase', 3),
(7, 4, '2019-06-20', 500000.00, 'Wire Transfer', 5),
(2, 3, '2014-07-10', 75000.00, 'Consulting Fee', 2),
(13, 6, '2018-08-05', 125000.00, 'Cryptocurrency Purchase', 1),
(10, 4, '2020-09-12', 350000.00, 'ETF Investment', 4),
(10, 8, '2016-10-18', 200000.00, 'Cryptocurrency Exchange', 3),
(9, 10, '2021-11-25', 450000.00, 'Call Option', 5),
(11, 12, '2017-12-03', 180000.00, 'Research Funding', 2),
(2, 14, '2023-01-07', 300000.00, 'Foreign Investment', 4),
(1, 7, '2012-02-14', 95000.00, 'Technology Consulting', 1),
(4, 5, '2022-03-22', 275000.00, 'Logistics Services', 3),
(5, 2, '2013-04-05', 625000.00, 'Banking Transaction', 5),
(6, 1, '2020-05-11', 150000.00, 'Equipment Purchase', 2),
(8, 3, '2024-06-18', 420000.00, 'Research Funding', 4),
(15, 8, '2016-07-25', 180000.00, 'Commodity Trade', 3);

INSERT INTO Property (OwnerID, Location, Value, SuspiciousLevel) VALUES
(1, '85 Newport Road, Careby, United Kingdom', 2500000.00, 3),
(2, '2439 Fittro Street, Arkansas, United States of America', 1750000.00, 2),
(3, '3 Bartley Rd, Singapore', 3200000.00, 1),
(4, 'Bellavista 67, Zaragoza, Spain', 1950000.00, 2),
(9, 'Gagarinskiy Pereulok 34, Moscow, Russia', 2800000.00, 4),
(5, '26 Al Seyahi Street, Dubai, UAE', 4500000.00, 3),
(12, '563 Rua do Eucalipto, Abreu E Lima, Brazil', 2200000.00, 5),
(15, 'Yi Yuan Lu 899hao 8dong 106hao, Jiangxi, China', 3100000.00, 1),
(11, 'Tas vezer u. 83, Tolna, Hungary', 1650000.00, 2),
(5, '30 Abdul Rahman Sedky St, Cairo, Egypt', 2350000.00, 3),
(8, 'R Cruzes 81, Braga, Portugal', 1850000.00, 1),
(13, 'E 40 Devli Road, Delhi, India', 2650000.00, 4),
(14, '71-1 Guui 2(i)-dong, Seoul, South Korea', 3300000.00, 2),
(6, 'Hidalgo Pte 234 Cp 64000, Nuevo Leon, Mexico', 2100000.00, 3),
(7, 'Prokhladnaya Ul bld 14, Dnepropetrovskaya oblast, Ukraine', 1950000.00, 5);

-- Insert data for Events
INSERT INTO Event (EventName, Location, Date, SuspiciousLevel) VALUES
('Global Finance Summit', 'London, UK', '2023-06-15', 2),
('Crypto Innovation Conference', 'Malta', '2022-09-20', 4),
('International Trade Expo', 'Dubai, UAE', '2024-03-10', 3),
('Technology Startups Forum', 'Singapore', '2023-11-05', 1),
('Energy Investment Summit', 'Qatar', '2022-12-12', 5),
('Digital Media Conference', 'Berlin, Germany', '2023-08-22', 2),
('Research and Development Symposium', 'San Francisco, USA', '2024-01-30', 1),
('Agricultural Innovations Expo', 'Sao Paulo, Brazil', '2023-05-17', 3),
('Pharmaceutical Research Conference', 'Zurich, Switzerland', '2022-07-08', 2),
('Renewable Energy Summit', 'Amsterdam, Netherlands', '2024-02-14', 1);

INSERT INTO Person_Event (PersonID, EventID) VALUES
(3, 1), -- Michael Chen at Global Finance Summit
(7, 2), -- Carlos Fernandez at Crypto Innovation Conference
(2, 3), -- Emily Johnson at International Trade Expo
(5, 4), -- Alexander Petrov at Technology Startups Forum
(10, 5), -- Omar Hassan at Energy Investment Summit
(9, 6), -- Elena Kovacs at Digital Media Conference
(12, 7), -- Raj Patel at Research and Development Symposium
(7, 8), -- Carlos Fernandez at Agricultural Innovations Expo
(13, 9), -- Sophia Kim at Pharmaceutical Research Conference
(6, 10), -- Aisha Mohammed at Renewable Energy Summit
(1, 1), -- John Smith at Global Finance Summit
(4, 3), -- Sarah Rodriguez at International Trade Expo
(8, 6), -- Wei Zhang at Digital Media Conference
(11, 8), -- Maria Silva at Agricultural Innovations Expo
(14, 9); -- Diego Morales at Pharmaceutical Research Conference

-- Insert data for Suspicious Activity Reports
INSERT INTO SuspiciousActivityReport (ReportDate, Institution, Category, Description, PersonID) VALUES
('2023-07-15', 'Financial Crimes Unit', 'Unusual transaction', 'Large cryptocurrency transfer from offshore account', 7),
('2022-11-20', 'International Banking Consortium', 'Potential money laundering', 'Multiple high-value transactions across different jurisdictions', 5),
('2024-01-10', 'Corporate Fraud Department', 'Suspicious ownership', 'Complex property ownership structure', 2),
('2023-09-05', 'Anti-corruption Agency', 'Conflict of interest', 'Potential unreported business relationships', 10),
('2022-08-12', 'Trade Regulatory Board', 'Trade anomalies', 'Unusual trade patterns with high-risk countries', 3);

-- Part 2: basic queries

-- Query 1: people with a property value greater than 2,000,000

SELECT p.Forename, p.Surname, pr.Location, pr.Value 
FROM Person p 
JOIN Property pr ON p.PersonID = pr.OwnerID 
WHERE pr.Value > 2000000; 

-- Query 2: people who have made transactions with a suspicious level of 5

SELECT p.Forename, p.Surname, t.TransactionDate, t.Amount, t.Type 
FROM Person p 
JOIN Transaction t ON p.PersonID = t.PersonID 
WHERE t.SuspiciousLevel = 5;

-- Part 3: medium queries

-- Query 3: people who have made transactions with companies from different countries

SELECT  p.Forename, p.Surname,  COUNT(DISTINCT c.Country) AS CountryCount
FROM Person p
JOIN Transaction t ON p.PersonID = t.PersonID
JOIN Company c ON t.CompanyID = c.CompanyID
GROUP BY p.PersonID
HAVING COUNT(DISTINCT c.Country) > 1;

-- Query 4: people who have made transactions with different suspicious levels

SELECT p.Forename, p.Surname, COUNT(DISTINCT t1.SuspiciousLevel) AS DifferentSuspiciousLevels
FROM Person p
JOIN Transaction t1 ON p.PersonID = t1.PersonID
JOIN Transaction t2 ON p.PersonID = t2.PersonID
WHERE t1.SuspiciousLevel != t2.SuspiciousLevel
GROUP BY p.PersonID
HAVING COUNT(DISTINCT t1.SuspiciousLevel) > 1;

-- Query 5: companies involved in transactions with the highest total amount

SELECT c.Name AS Company, SUM(t.Amount) AS TotalTransactionAmount
FROM Company c
JOIN Transaction t ON c.CompanyID = t.CompanyID
GROUP BY c.CompanyID
ORDER BY TotalTransactionAmount DESC
LIMIT 5;

-- Query 6: People with suspicious activity reports in multiple categories
SELECT p.Forename, p.Surname, COUNT(DISTINCT sar.Category) AS CategoryCount
FROM Person p
JOIN SuspiciousActivityReport sar ON p.PersonID = sar.PersonID
GROUP BY p.PersonID
HAVING CategoryCount > 1
ORDER BY CategoryCount DESC;

-- Part 4: advanced queries

-- Query 7: people who made more transactions than the average number of transactions

SELECT p.Forename, p.Surname, COUNT(t.TransactionID) AS TotalTransactions
FROM Person p
JOIN Transaction t ON p.PersonID = t.PersonID
GROUP BY p.PersonID
HAVING COUNT(t.TransactionID) > (
    SELECT AVG(TransactionCount)
    FROM (
        SELECT COUNT(TransactionID) AS TransactionCount
        FROM Transaction
        GROUP BY PersonID
    ) as TransactionCounts
);

-- Query 8: people with transactions above the average transaction amount for each company

SELECT p.Forename, p.Surname, c.Name AS CompanyName, SUM(t.Amount) AS PersonTotalAmount
FROM Person p
JOIN Transaction t ON p.PersonID = t.PersonID
JOIN Company c ON t.CompanyID = c.CompanyID
GROUP BY p.PersonID, c.CompanyID
HAVING SUM(t.Amount) > (
    SELECT AVG(TransactionAmount)
    FROM (
        SELECT SUM(t2.Amount) AS TransactionAmount
        FROM Transaction t2
        WHERE t2.CompanyID = c.CompanyID
        GROUP BY t2.PersonID
    ) AS CompanyTransactionAmounts
);

-- Query 9: overall anaylsis of suspiciousness for people, based on events, transactions, and reports

WITH EventSuspiciousness AS (
    SELECT 
        p.PersonID,
        p.Forename,
        p.Surname,
        AVG(e.SuspiciousLevel) AS AvgEventSuspiciousness,
        AVG(t.SuspiciousLevel) AS AvgTransactionSuspiciousness,
        COUNT(DISTINCT sar.ReportID) AS SuspiciousReportCount
    FROM Person p
    LEFT JOIN Person_Event pe ON p.PersonID = pe.PersonID
    LEFT JOIN Event e ON pe.EventID = e.EventID
    LEFT JOIN Transaction t ON p.PersonID = t.PersonID
    LEFT JOIN SuspiciousActivityReport sar ON p.PersonID = sar.PersonID
    GROUP BY p.PersonID
)
SELECT 
    Forename, 
    Surname, 
    AvgEventSuspiciousness,
    AvgTransactionSuspiciousness,
    SuspiciousReportCount,
    CASE 
        WHEN AvgEventSuspiciousness >= 4 OR 
             AvgTransactionSuspiciousness >= 4 OR 
             SuspiciousReportCount > 1 
        THEN 'High Risk'
        WHEN AvgEventSuspiciousness >= 3 OR 
             AvgTransactionSuspiciousness >= 3 OR 
             SuspiciousReportCount = 1 
        THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS RiskProfile
FROM EventSuspiciousness
ORDER BY 
    AvgEventSuspiciousness DESC, 
    AvgTransactionSuspiciousness DESC, 
    SuspiciousReportCount DESC
LIMIT 15;
