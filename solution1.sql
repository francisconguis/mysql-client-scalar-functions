ALTER TABLE Client
    MODIFY COLUMN ClientNo VARCHAR(10) NOT NULL,
    MODIFY COLUMN FirstName VARCHAR(50) NOT NULL,
    MODIFY COLUMN MidName VARCHAR(50) NULL,
    MODIFY COLUMN Surname VARCHAR(50) NOT NULL,
    MODIFY COLUMN Street VARCHAR(100) NULL,
    MODIFY COLUMN City VARCHAR(50) NULL,
    MODIFY COLUMN Zip VARCHAR(10) NULL,
    MODIFY COLUMN CreditLimit DECIMAL(10, 2) DEFAULT 0.00;
    
ALTER TABLE Client
    ADD PRIMARY KEY (ClientNo);

ALTER TABLE Client
    ADD COLUMN MobileNo VARCHAR(20) AFTER Zip,
    ADD COLUMN Landline VARCHAR(20) AFTER MobileNo,
    ADD COLUMN Email VARCHAR(100) AFTER Landline;
    
SELECT * FROM client;
    
-- 1. Update Email Address
UPDATE Client
SET email = LOWER(CONCAT(
    LEFT(TRIM(Surname), 4),
    LEFT(TRIM(FirstName), 2),
    LEFT(TRIM(MidName), 1),
    '@gmail.com'
));

-- 2. Update Mobile Numbers for C1 and C5
UPDATE Client
SET mobileno = '0915-111-2222'
WHERE ClientNo = 'C1';

UPDATE Client
SET mobileno = '0933-111-2222'
WHERE ClientNo = 'C5';

-- 3. Update Landline Numbers for C2, C3, C4, C8, and C9
UPDATE Client
SET landline = CASE ClientNo
    WHEN 'C2' THEN '5555555'
    WHEN 'C3' THEN '9111111'
    WHEN 'C4' THEN '9108976'
    WHEN 'C8' THEN '7801212'
    WHEN 'C9' THEN '7779999'
    ELSE landline
END
WHERE ClientNo IN ('C2', 'C3', 'C4', 'C8', 'C9');

-- 4. Display Formatted Name and Primary Contact Info (Descending by Last Name)
SELECT 
    CONCAT(
        TRIM(FirstName), SPACE(1),
        LEFT(TRIM(MidName), 1), '.', SPACE(1),
        UPPER(TRIM(Surname))
    ) AS `Full Name`,
    COALESCE(
        NULLIF(TRIM(mobileno), ''),
        NULLIF(TRIM(landline), ''),
        NULLIF(TRIM(email), '')
    ) AS `Primary Contact`
FROM Client
ORDER BY TRIM(Surname) DESC;

-- 5. Display ClientNo, Combined Address, and Formatted Credit Limit
SELECT 
    ClientNo,
    CONCAT(TRIM(Street), ', ', TRIM(City), ', ', TRIM(Zip)) AS `Address`,
    FORMAT(CreditLimit, 2) AS `Credit Limit`
FROM Client;