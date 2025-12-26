-- Create and use database
CREATE DATABASE Insurance1;
USE Insurance1;

-- PERSON table
CREATE TABLE person (
    driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(30)
);

-- CARS table
CREATE TABLE cars (
    reg_num VARCHAR(10) PRIMARY KEY,
    model VARCHAR(20),
    year INT
);

-- OWNERS table
CREATE TABLE owners (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES cars(reg_num)
);

-- PARTICIPATED table
CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT PRIMARY KEY,
    damage_amount INT,
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES cars(reg_num)
);

-- ACCIDENT table
CREATE TABLE accident (
    report_num INT,
    accident_date DATE,
    location VARCHAR(20),
    FOREIGN KEY (report_num) REFERENCES participated(report_num)
);

-- Insert into PERSON
INSERT INTO person VALUES
('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajaji Nagar'),
('A03','Smith','Ashok Nagar'),
('A04','Venu','NR Colony'),
('A05','John','Hanumanth Nagar');

SELECT * FROM person;

-- Insert into CARS
INSERT INTO cars VALUES
('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

SELECT * FROM cars;


INSERT INTO owners VALUES
('A01','KA052250'),
('A02','KA031181'),
('A03','KA095477'),
('A04','KA053408'),
('A05','KA041702');

SELECT * FROM owners;


INSERT INTO participated VALUES
('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);

SELECT * FROM participated;

-- Insert into ACCIDENT
INSERT INTO accident VALUES
(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South End Circle'),
(13,'2003-01-21','Bull Temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2004-03-05','Kanakapura Road');

SELECT * FROM accident;

-- Update damage amount
UPDATE participated
SET damage_amount = 25000
WHERE report_num = 12;

SELECT * FROM participated;

-- Count accidents on 2008-02-17
SELECT COUNT(*)
FROM participated p
JOIN accident a
ON p.report_num = a.report_num
WHERE a.accident_date = '2008-02-17';

-- Average damage amount
SELECT AVG(damage_amount) FROM participated;
