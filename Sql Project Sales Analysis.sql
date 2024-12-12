-- Data Cleaning
-- Remove duplicate records in the Sales table
DELETE FROM Sales
WHERE SaleID NOT IN (
    SELECT MIN(SaleID)
    FROM Sales
    GROUP BY SaleID
);

-- Total Revenue
SELECT SUM(Amount) AS TotalRevenue FROM Sales;

-- Sales by Category
SELECT p.Category, SUM(s.Amount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;

-- Monthly Sales Trends
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, SUM(Amount) AS MonthlySales
FROM Sales
GROUP BY Month
ORDER BY Month;

-- Top 5 Customers by Spending
SELECT c.CustomerID, c.Name, SUM(s.Amount) AS TotalSpent
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC
LIMIT 5;

-- Best-Selling Products
SELECT p.ProductID, p.ProductName, SUM(s.Quantity) AS TotalQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 5;

-- Regional Sales Performance
SELECT c.Region, SUM(s.Amount) AS TotalSales
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY TotalSales DESC;