--Using Stored Procedure to get the Customer Risk Report Instanly

CREATE PROCEDURE GetCustomerRiskReport
AS
BEGIN
    SELECT * FROM CustomerRiskView
    ORDER BY credit_score ASC;
END;


-- Calling the Stored Procedure

EXEC GetCustomerRiskReport;
