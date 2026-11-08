-- Task 2: Advanced DDL, DML, and Scalar Functions

SELECT * FROM client;

-- 1. Display Full Name & Email Local Name for 'Ma' Cities
SELECT 
    CONCAT(TRIM(FirstName), ' ', TRIM(Surname)) AS `Full Name`,
    City,
    email AS `Email Address`,
    SUBSTRING_INDEX(email, '@', 1) AS `Local Username`
FROM Client
WHERE TRIM(City) LIKE 'Ma%';

-- 2. Insert 1 Record without Email and Landline
INSERT INTO Client (
    ClientNo, FirstName, MidName, Surname, Street, City, Zip, MobileNo, Landline, Email, CreditLimit
) VALUES (
    'C12', 'Kenji', 'Sato', 'Tanaka', 'Mabini', 'Makati', '1224', '0918-999-8888', NULL, NULL, 65000.00
);

-- 3. Filter by Terminal Zip Character ('1' or '4') and Credit Limit (55k - 90k)
SELECT 
    ClientNo,
    CONCAT(TRIM(Street), ', ', TRIM(City), ', ', TRIM(Zip)) AS `Address`,
    CONCAT('$', FORMAT(CreditLimit, 2)) AS `Credit Limit`
FROM Client
WHERE RIGHT(TRIM(Zip), 1) IN ('1', '4')
  AND CreditLimit BETWEEN 55000 AND 90000;