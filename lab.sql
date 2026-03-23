-- Exercise 1:--- 
create table if not exists authors(
id int auto_increment primary key,
author_name varchar(100) not null
);

create table if not exists titles(
title_id int auto_increment primary key,
title_name varchar(100),
word_count int,
views int,
author_id int ,
foreign key (author_id) references authors(id)
);

insert into authors(author_name)
values('Maria Charlotte'),
('Juan Perez'),
('Gemma Alcocer');


insert into titles(title_name,word_count,views,author_id)
values('Best Paint Colors', 814, 14,1),
('Small Space Decorating Tips', 1146, 221,2),
('Hot Accessories', 986, 105,1),
('Mixing Textures', 765, 22,1),
('Kitchen Refresh', 1242, 307,2),
('Homemade Art Hacks', 1002, 193,1),
('Refinishing Wood Floors', 1571, 7542,3);

SELECT 
    a.author_name AS author,
    t.title_name AS title,
    t.word_count,
    t.views
FROM titles t
INNER JOIN authors a
ON t.author_id = a.id;
 -- exercise 2---
 use ailane;
CREATE TABLE customers (
   customer_id int NOT NULL AUTO_INCREMENT,
   customer_name varchar(200) DEFAULT NULL,
status varchar(200) DEFAULT 'None',
  mileage int DEFAULT NULL,
   PRIMARY KEY (customer_id)
 );
INSERT INTO customers (customer_name, status,mileage)
VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);
CREATE TABLE aircrafts (
   name varchar(50) NOT NULL,
   total_aircraft_seats int DEFAULT NULL,
   PRIMARY KEY (name)
 ); 
INSERT INTO aircrafts (name, total_aircraft_seats)
VALUES
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);
CREATE TABLE flights (
   flight_number varchar(300) NOT NULL,
   aircraft varchar(45) NOT NULL,
   flight_mileage int DEFAULT NULL,
   PRIMARY KEY (flight_number),
   KEY aircraft_idx (aircraft),
   CONSTRAINT aircraft FOREIGN KEY (aircraft) REFERENCES aircrafts (name)
 );
INSERT INTO flights (flight_number, aircraft, flight_mileage)
VALUES
('DL143', 'Boeing 747', 135),
('DL122', 'Airbus A330', 4370),
('DL53', 'Boeing 777', 2078),
('DL222', 'Boeing 777', 1765),
('DL37', 'Boeing 747', 531);

CREATE TABLE bookings (
   customer_id int DEFAULT NULL,
   flight_number varchar(300) DEFAULT NULL,
   KEY customer_id_idx (customer_id),
   KEY flight_number_idx (flight_number),
   CONSTRAINT customer_id FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
   CONSTRAINT flight_number FOREIGN KEY (flight_number) REFERENCES flights (flight_number)
 );
INSERT INTO bookings (customer_id, flight_number)
VALUES
(1, 'DL143'),
(1, 'DL122'),
(2, 'DL122'),
(3, 'DL122'),
(3, 'DL53'),
(3, 'DL222');

	-- ---- Exercise 3- -------
SELECT COUNT(DISTINCT flight_number) FROM flights; -- 5
SELECT AVG(flight_mileage) FROM flights; -- 1775.8000
SELECT AVG(total_aircraft_seats) FROM aircrafts; -- 300.0000
SELECT status, AVG(mileage) FROM customers GROUP BY status; 
-- Silver	98576.5000
-- None	4330.5000
-- Gold	253174.5000
SELECT status, MAX(mileage) FROM customers GROUP BY status;
-- Silver	136773
-- None	6008
-- Gold	300582

SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%'; -- 2
SELECT * FROM flights WHERE flight_mileage BETWEEN 300 AND 2000;
-- DL222	Boeing 777	1765
-- DL37	Boeing 747	531
SELECT c.status, AVG(f.flight_mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;
-- DL222	Boeing 777	1765
-- DL37	Boeing 747	531

SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN flights f ON b.flight_number = f.flight_number
JOIN aircrafts a ON f.aircraft = a.name
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;
-- Boeing 777	2
