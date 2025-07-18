# 💳 Loan Default Risk Reporting System

This project simulates a credit risk reporting system for a digital bank using SQL. It categorizes customers based on their credit scores and payment history, helping stakeholders assess the likelihood of loan defaults. The system is structured for integration with BI tools like Power BI, making it suitable for dashboards and executive reporting.

---

## 🔍 Objective

To develop a data-driven risk assessment system using SQL that enables banks to:
- Classify customers into risk segments (Low, Medium, High)
- Generate monthly credit risk reports
- Support decision-making with structured and visualized insights

---

## 🧠 Risk Classification Logic

| Risk Level | Criteria |
|------------|----------|
| **Low**    | Credit Score ≥ 750 and no missed payments |
| **Medium** | Credit Score between 600 and 749 |
| **High**   | Credit Score < 600 or missed payments |

This logic mirrors real-world risk models used by financial institutions.

---

## 🗃️ Database Design

Four core tables model the customer-financial relationship:

- **Customers** – Stores customer information  
- **Loans** – Contains loan details linked to customers  
- **Payments** – Tracks payment history  
- **CreditScores** – Holds customer credit scores  

---

## ⚙️ Components

| File | Description |
|------|-------------|
| `schema.sql` | DDL statements to create tables |
| `sample_data.sql` | Sample dataset |
| `risk_view.sql` | Creates a reusable view (`CustomerRiskView`) for categorizing risk |
| `procedure.sql` | Stored procedure (`GetCustomerRiskReport`) for monthly reporting |
| `full_code.sql` | Consolidated SQL script including schema, data, view, and procedure |

---

## 📊 Reporting Output

A sample output of the stored procedure:

| customer_id | customer_name | credit_score | missed_payments | risk_level  |
|-------------|----------------|--------------|------------------|-------------|
| 6           | Neha Patel     | 590          | 1                | High Risk   |
| 9           | Rohit Jain     | 600          | 0                | Medium Risk |
| 4           | Sneha Rao      | 620          | 0                | Medium Risk |
| 8           | Anjali Roy     | 650          | 0                | Medium Risk |
| 2           | Priya Nair     | 680          | 1                | Medium Risk |
| 7           | Vikram Das     | 705          | 0                | Medium Risk |
| 10          | Divya Menon    | 730          | 0                | Medium Risk |
| 3           | Rahul Sharma   | 740          | 0                | Medium Risk |
| 1           | Arjun Mehta    | 765          | 0                | Low Risk    |
| 5           | Karan Singh    | 790          | 0                | Low Risk    |


This output can be consumed by Power BI for dashboards or exported for compliance/audit purposes.

---

## 🛠️ Tools & Technologies

- **SQL Server Management Studio (SSMS)**
- **Transact-SQL (T-SQL)**
- **GitHub** (Version Control)
- **Power BI** (Optional for Visualization)

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/loan-risk-reporting-system.git
