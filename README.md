# Client Data Management & SQL Scalar Operations

A MySQL data manipulation, DDL alteration, and scalar transformation project based on customer demographic, location, and financial datasets. This repository highlights data cleaning, schema extensions, automated string formatting, contact fallback routing using conditional expressions, and criteria-driven queries.

---

## Repository Structure

- `Client.csv` - Baseline dataset containing client demographics, addresses, and initial credit limits.
- `solution1.sql` - Complete implementation script for Task 1 (DDL alterations, string manipulation, data updates, and fallback contact routing).
- `solution2.sql` - Complete implementation script for Task 2 (Sub-string token parsing, partial record ingestion, and compound conditional filtering).

---

## Dataset Schema

The `Client` table is structured with the following schema specifications:

| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `ClientNo` | `VARCHAR(10)` | `PRIMARY KEY` | Unique customer alphanumeric code (e.g., `C1`, `C2`) |
| `FirstName` | `VARCHAR(50)` | `NOT NULL` | Client given name |
| `MidName` | `VARCHAR(50)` | `NULL` | Client middle name |
| `Surname` | `VARCHAR(50)` | `NOT NULL` | Client last name |
| `Street` | `VARCHAR(100)` | `NULL` | Street address / road identifier |
| `City` | `VARCHAR(50)` | `NULL` | City / municipality |
| `Zip` | `VARCHAR(10)` | `NULL` | Postal code |
| `MobileNo` | `VARCHAR(20)` | `NULL` | Cellular telephone contact |
| `Landline` | `VARCHAR(20)` | `NULL` | Fixed-line telephone contact |
| `Email` | `VARCHAR(100)` | `NULL` | Standardized electronic mail address |
| `CreditLimit` | `DECIMAL(10, 2)`| `DEFAULT 0.00` | Account credit allowance |

---

## Scalar Functions Implemented

The tasks implement built-in MySQL scalar functions across several categories:
- **String Parsing & Extraction:** `LEFT()`, `MID()`, `SUBSTR()`, `SUBSTRING_INDEX()`, `RIGHT()`
- **String Cleaning & Casing:** `TRIM()`, `LTRIM()`, `RTRIM()`, `UPPER()`, `UCASE()`, `LOWER()`
- **String Formatting & Spacing:** `CONCAT()`, `SPACE()`
- **Number & Currency Formatting:** `FORMAT()`
- **Null Handling & Fallback Selection:** `COALESCE()`, `NULLIF()`

---

## Task 1

### Problem Set
1. Alter the `Client` table and add columns `mobileno`, `landline`, and `email` (in this order) using appropriate data types and sizes via the `ALTER TABLE` command.
2. Create an email address for each record in the `Client` table containing the first 4 characters of the surname, the first 2 characters of the first name, the first character of the middle name, plus `@gmail.com`, and update the `email` attribute for all records.
3. Update `C1` and `C5` with a value for `mobileno`.
4. Update `C2`, `C3`, `C4`, `C8`, and `C9` with values for `landline`.
5. Display the first name, middle initial, and uppercase last name (with spaces in between), along with the mobile number if it has a value; if none, display the landline; if none, display the email address, sorted in descending order of the last name.
6. Display `ClientNo`, the unified address in one column (`Street`, `City`, `Zip`), and the credit limit formatted with 2 decimal places and commas.

### Solution Overview (`solution1.sql`)
1. **Schema Expansion (DDL)**: Modified table architecture by appending `mobileno`, `landline`, and `email` attributes sequentially after `Zip` using `ALTER TABLE ... ADD COLUMN`.
2. **Automated Credential Generation**: Sliced and concatenated substrings from name attributes using `LEFT`, `TRIM`, and `LOWER` to populate uniform email credentials via `UPDATE`.
3. **Targeted Mobile Allocation (DML)**: Updated primary cellular contact details for designated client accounts `C1` and `C5`.
4. **Batch Landline Injection (DML)**: Populated fixed-line telephone records across accounts `C2`, `C3`, `C4`, `C8`, and `C9` using conditional updates.
5. **Hierarchical Contact Fallback Routing**: Formatted client names using `UPPER`, `MID`, and `SPACE`, resolving communication channels dynamically across mobile, landline, and email tiers via `COALESCE` and `NULLIF`.
6. **Unified Address & Financial Normalization**: Merged multi-column geographic attributes into a single address field and formatted credit limits into standard monetary notation using `FORMAT`.

---

## Task 2

### Problem Set
1. Display the concatenated full name of the client and the user or local name from the email address (the part before the `@` sign) if the client lives in a city with name starting with 'Ma'.
2. Insert 1 record, populating all attributes except for the email address and landline.
3. Display `ClientNo`, the address in one column (`Street`, `City`, `Zip`), and the credit limit formatted with 2 decimal places and commas if the following conditions are met:
   - 3.1 The last character of the zip code is `1` or `4`.
   - 3.2 The credit limit is within the 55k to 90k range ($55,000 to $90,000).

### Solution Overview (`solution2.sql`)
1. **Local Email Username Extraction**: Extracted the email user identifier prior to the `@` delimiter using `SUBSTRING_INDEX` alongside concatenated full names for clients residing in cities with the `'Ma%'` prefix.
2. **Partial Record Ingestion (DML)**: Inserted a client profile omitting contact channels (`email` and `landline` set to `NULL`) to evaluate nullable attribute behavior.
3. **Targeted Multi-Condition Geographic & Credit Rollup**: Concatenated full postal addresses while filtering by terminal postal digits (`'1'` or `'4'`) using `RIGHT` and bounding credit exposure to the $55,000–$90,000 tier with `FORMAT`.

---

## How to Execute the Scripts

1. **Import the Dataset:**
   Import `Client.csv` into your MySQL schema using the MySQL Workbench Table Data Import Wizard or via the command line:
   ```sql
   LOAD DATA LOCAL INFILE 'Client.csv'
   INTO TABLE Client
   FIELDS TERMINATED BY ','
   ENCLOSED BY '"'
   LINES TERMINATED BY '\n'
   IGNORE 1 ROWS;
