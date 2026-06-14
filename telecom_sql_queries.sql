create database telecom;

CREATE TABLE telecom_customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Gender VARCHAR(20),
    Age INT,
    City VARCHAR(100),
    Contract VARCHAR(50),
    Monthly_Charge DECIMAL(10,2),
    Total_Revenue DECIMAL(10,2),
    Tenure_Months INT,
    Churn_Flag INT
);

SELECT TOP 1 *
FROM [telecom].[dbo].[Telecom churn data];


SELECT COUNT(*) AS Total_Customers
FROM [telecom].[dbo].[Telecom churn data];--total customers

SELECT COUNT(*) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
WHERE Churn_Label = 1;  --churned customers

SELECT
ROUND(
COUNT(CASE WHEN Churn_Label = 1 THEN 1 END) * 100.0
/ COUNT(*),
2
) AS Churn_Rate
FROM [telecom].[dbo].[Telecom churn data]; --churn rate %

SELECT COUNT(*) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
WHERE Churn_Label = 1;  --Total Churned Customers

SELECT COUNT(*) AS Active_Customers
FROM [telecom].[dbo].[Telecom churn data]
WHERE Churn_Label = 0;  --Total Active Customers

SELECT
Gender,
COUNT(*) AS Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Gender;  --customer by gender

SELECT
Age_Group,
COUNT(*) AS Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Age_Group;  --customer by age group

SELECT
Contract,
COUNT(*) AS Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Contract; --customers by contact

SELECT
Contract,
AVG(Monthly_Charge) AS Avg_Monthly_Charge
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Contract; --Average Monthly Charge by Contract

SELECT
SUM(Total_Revenue) AS Total_Revenue
FROM [telecom].[dbo].[Telecom churn data];  --total revenue

SELECT
City,
SUM(Total_Revenue) AS Revenue
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY City
ORDER BY Revenue DESC; --revenue by city

SELECT
Contract,
COUNT(*) AS Customers,
SUM(CAST(Churn_Label AS INT)) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Contract;  --Churn by Contract Type

SELECT
Age_Group,
COUNT(*) AS Customers,
SUM(CAST(Churn_Label AS INT)) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Age_Group; --Churn by Age Group

SELECT
City,
SUM(CAST(Churn_Label AS INT)) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY City
ORDER BY Churned_Customers DESC; --Top Cities with Highest Churn

SELECT
Payment_Method,
COUNT(*) AS Customers,
SUM(CAST(Churn_Label AS INT)) AS Churned_Customers
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Payment_Method; --Churn by Payment Method

SELECT
    Contract,
    ROUND(
        SUM(CAST(Churn_Label AS FLOAT))*100.0/COUNT(*),
        2
    ) AS Churn_Rate
FROM [telecom].[dbo].[Telecom churn data]
GROUP BY Contract
ORDER BY Churn_Rate DESC; --Contract Type with Highest Churn Rate

SELECT
Customer_ID,
Total_Revenue,
RANK() OVER(
ORDER BY Total_Revenue DESC
) AS Revenue_Rank
FROM [telecom].[dbo].[Telecom churn data]; --Rank Customers by Revenue (Window Function)

SELECT
Customer_ID,
Total_Revenue,
SUM(Total_Revenue)
OVER(
ORDER BY Customer_ID
) AS Running_Revenue
FROM [telecom].[dbo].[Telecom churn data]; --Running Revenue Total (Window Function)

SELECT
Customer_ID,
Contract,
Tenure_in_Months,
Monthly_Charge
FROM [telecom].[dbo].[Telecom churn data]
WHERE Churn_Label = 1
AND Tenure_in_Months < 12; --High-Risk Customers

