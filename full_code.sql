create database LoanRiskDB;
use LoanRiskDB;

--Creating Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(100),
    age INT,
    income DECIMAL(10, 2),
    city NVARCHAR(50)
);


--Creating Loans Table


CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    loan_amount DECIMAL(10, 2),
    interest_rate DECIMAL(5, 2),
    starting_date DATE,
    loan_term_months INT
);

--Creating Payments Table

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    loan_id INT FOREIGN KEY REFERENCES Loans(loan_id),
    payment_date DATE,
    due_date DATE,
    payment_amount DECIMAL(10, 2),
    status_of_payment NVARCHAR(20) 
);

--Creating Credit Scrores Table

CREATE TABLE CreditScores (
    customer_id INT PRIMARY KEY FOREIGN KEY REFERENCES Customers(customer_id),
    credit_score INT,
    last_updated DATE
);

--Inserting Customers Table

INSERT INTO Customers (customer_id, customer_name, age, income, city) VALUES
(1, 'Arjun Mehta', 34, 75000.00, 'Mumbai'),
(2, 'Priya Nair', 29, 62000.00, 'Chennai'),
(3, 'Rahul Sharma', 41, 89000.00, 'Delhi'),
(4, 'Sneha Rao', 37, 67000.00, 'Bangalore'),
(5, 'Karan Singh', 45, 95000.00, 'Hyderabad'),
(6, 'Neha Patel', 31, 56000.00, 'Ahmedabad'),
(7, 'Vikram Das', 38, 72000.00, 'Pune'),
(8, 'Anjali Roy', 27, 61000.00, 'Kolkata'),
(9, 'Rohit Jain', 36, 80000.00, 'Jaipur'),
(10, 'Divya Menon', 33, 69000.00, 'Coimbatore');


--Inserting Loans Table

INSERT INTO Loans (loan_id, customer_id, loan_amount, interest_rate, starting_date, loan_term_months) VALUES
(101, 1, 200000.00, 9.5, '2025-01-15', 24),
(102, 2, 150000.00, 10.0, '2025-03-10', 18),
(103, 3, 300000.00, 8.5, '2025-01-01', 36),
(104, 4, 180000.00, 9.0, '2025-02-20', 12),
(105, 5, 250000.00, 8.8, '2025-01-01', 24),
(106, 6, 130000.00, 10.2, '2025-06-01', 18),
(107, 7, 220000.00, 9.7, '2025-01-15', 24),
(108, 8, 110000.00, 11.0, '2025-05-01', 12),
(109, 9, 175000.00, 8.9, '2025-04-10', 18),
(110, 10, 195000.00, 9.1, '2025-02-05', 24);


--Inserting Payments Table

INSERT INTO Payments (payment_id, loan_id, payment_date, due_date, payment_amount, status_of_payment) VALUES
(1001, 101, '2025-02-15', '2025-02-10', 10000.00, 'Late'),
(1002, 101, '2025-03-10', '2025-03-10', 10000.00, 'On Time'),
(1003, 102, '2025-04-15', '2025-04-10', 8500.00, 'Late'),
(1004, 103, '2025-01-10', '2025-01-10', 9000.00, 'On Time'),
(1005, 104, '2025-03-20', '2025-03-10', 15000.00, 'Late'),
(1006, 105, '2025-02-01', '2025-02-01', 10500.00, 'On Time'),
(1007, 106, '2025-07-05', '2025-07-01', 8500.00, 'Missed'),
(1008, 107, '2025-03-15', '2025-03-01', 9500.00, 'Late'),
(1009, 108, '2025-06-01', '2025-06-01', 9000.00, 'On Time'),
(1010, 109, '2025-05-15', '2025-05-10', 9800.00, 'Late'),
(1011, 110, '2025-04-01', '2025-04-01', 9500.00, 'On Time'),
(1012, 102, '2025-05-15', '2025-05-10', 8500.00, 'Missed'),
(1013, 103, '2025-02-01', '2025-02-01', 9000.00, 'On Time'),
(1014, 106, '2025-08-01', '2025-08-01', 8500.00, 'On Time'),
(1015, 109, '2025-06-10', '2025-06-10', 9800.00, 'On Time');


--Inserting Credit Scrores Table

INSERT INTO CreditScores (customer_id, credit_score, last_updated) VALUES
(1, 765, '2025-06-30'),
(2, 680, '2025-06-30'),
(3, 740, '2025-06-30'),
(4, 620, '2025-06-30'),
(5, 790, '2025-06-30'),
(6, 590, '2025-06-30'),
(7, 705, '2025-06-30'),
(8, 650, '2025-06-30'),
(9, 600, '2025-06-30'),
(10, 730, '2025-06-30');

--If credit score needs to be calculated manually
--credit_score = 900 - (number_of_missed_payments × 30)- (number_of_late_payments × 10)


-- Creating View which has query for risk classication

CREATE VIEW CustomerRiskView AS
SELECT 
    c.customer_id,
    c.customer_name,
    cs.credit_score,
    ISNULL(mp.missed_count, 0) AS missed_payments,

    CASE
        WHEN cs.credit_score >= 750 AND ISNULL(mp.missed_count, 0) = 0 THEN 'Low Risk'
        WHEN cs.credit_score BETWEEN 600 AND 749 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS risk_level

FROM Customers c
JOIN CreditScores cs ON c.customer_id = cs.customer_id

LEFT JOIN (
    SELECT l.customer_id, COUNT(*) AS missed_count
    FROM Payments p
    JOIN Loans l ON p.loan_id = l.loan_id
    WHERE p.status_of_payment = 'Missed'
    GROUP BY l.customer_id
) mp ON c.customer_id = mp.customer_id;


-- Using View

SELECT * FROM CustomerRiskView;


--Using Stored Procedure to get the Customer Risk Report Instanly

CREATE PROCEDURE GetCustomerRiskReport
AS
BEGIN
    SELECT * FROM CustomerRiskView
    ORDER BY credit_score ASC;
END;


-- Calling the Stored Procedure

EXEC GetCustomerRiskReport;




