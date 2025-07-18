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
