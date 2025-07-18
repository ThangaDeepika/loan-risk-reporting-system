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






