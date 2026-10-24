USE EcommerceAnalytics;


-- =====================================================
-- 05 - SALES ANALYSIS
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. TOTAL SALES
-- =====================================================

SELECT
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM OrderItems oi;


-- =====================================================
-- 2. TOTAL QUANTITY SOLD
-- =====================================================

SELECT
    SUM(oi.Quantity) AS TotalQuantitySold
FROM OrderItems oi;


-- =====================================================
-- 3. TOTAL NUMBER OF ORDERS
-- =====================================================

SELECT
    COUNT(DISTINCT oi.OrderID) AS TotalOrders
FROM OrderItems oi;


-- =====================================================
-- 4. AVERAGE ORDER VALUE
-- =====================================================

SELECT
    ROUND(
        SUM(oi.Quantity * oi.UnitPrice)
        / COUNT(DISTINCT oi.OrderID),
        2
    ) AS AverageOrderValue
FROM OrderItems oi;


-- =====================================================
-- 5. SALES BY PRODUCT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalSales DESC;


-- =====================================================
-- 6. TOP 5 PRODUCTS BY SALES
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalSales DESC
LIMIT 5;


-- =====================================================
-- 7. SALES BY CATEGORY
-- =====================================================

SELECT
    p.Category,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY p.Category
ORDER BY TotalSales DESC;


-- =====================================================
-- 8. SALES BY SUBCATEGORY
-- =====================================================

SELECT
    p.SubCategory,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY p.SubCategory
ORDER BY TotalSales DESC;


-- =====================================================
-- 9. SALES BY CUSTOMER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalSales DESC;


-- =====================================================
-- 10. TOP 10 CUSTOMERS BY SALES
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalSales DESC
LIMIT 10;


-- =====================================================
-- 11. SALES BY COUNTRY
-- =====================================================

SELECT
    o.ShippingCountry AS Country,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY o.ShippingCountry
ORDER BY TotalSales DESC;


-- =====================================================
-- 12. SALES BY CITY
-- =====================================================

SELECT
    o.ShippingCity AS City,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY o.ShippingCity
ORDER BY TotalSales DESC;


-- =====================================================
-- 13. SALES BY PAYMENT METHOD
-- =====================================================

SELECT
    o.PaymentMethod,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY o.PaymentMethod
ORDER BY TotalSales DESC;


-- =====================================================
-- 14. DAILY SALES
-- =====================================================

SELECT
    o.OrderDate,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS DailySales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY o.OrderDate
ORDER BY o.OrderDate;


-- =====================================================
-- 15. MONTHLY SALES
-- =====================================================

SELECT
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS MonthlySales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY
    OrderYear,
    OrderMonth;


-- =====================================================
-- 16. SALES BY ORDER STATUS
-- =====================================================

SELECT
    o.OrderStatus,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Orders o
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY o.OrderStatus
ORDER BY TotalSales DESC;


-- =====================================================
-- 17. HIGHEST VALUE ORDERS
-- =====================================================

SELECT
    o.OrderID,
    o.OrderDate,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
ORDER BY OrderValue DESC
LIMIT 10;


-- =====================================================
-- 18. ORDERS WITH SALES ABOVE 2000
-- =====================================================

SELECT
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    o.OrderID,
    c.FirstName,
    c.LastName
HAVING OrderValue > 2000
ORDER BY OrderValue DESC;


-- =====================================================
-- 19. PRODUCT SALES WITH PROFIT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS QuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,
    SUM(oi.Quantity * (oi.UnitPrice - p.CostPrice)) AS TotalProfit
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY TotalProfit DESC;


-- =====================================================
-- 20. PROFIT BY CATEGORY
-- =====================================================

SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,
    SUM(oi.Quantity * (oi.UnitPrice - p.CostPrice)) AS TotalProfit
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY p.Category
ORDER BY TotalProfit DESC;


-- =====================================================
-- 21. PROFIT MARGIN BY CATEGORY
-- =====================================================

SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,
    SUM(oi.Quantity * (oi.UnitPrice - p.CostPrice)) AS TotalProfit,
    ROUND(
        SUM(oi.Quantity * (oi.UnitPrice - p.CostPrice))
        / SUM(oi.Quantity * oi.UnitPrice) * 100,
        2
    ) AS ProfitMarginPercentage
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY p.Category
ORDER BY ProfitMarginPercentage DESC;


-- =====================================================
-- 22. SALES PERFORMANCE BY CUSTOMER GENDER
-- =====================================================

SELECT
    c.Gender,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY c.Gender
ORDER BY TotalSales DESC;


-- =====================================================
-- 23. SALES BY CUSTOMER COUNTRY
-- =====================================================

SELECT
    c.Country,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY c.Country
ORDER BY TotalSales DESC;


-- =====================================================
-- 24. PRODUCTS NEVER SOLD
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.StockQuantity
FROM Products p
LEFT JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
WHERE oi.ProductID IS NULL;


-- =====================================================
-- 25. BEST SELLING PRODUCT BY QUANTITY
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalQuantitySold DESC
LIMIT 1;