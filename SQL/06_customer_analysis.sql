USE EcommerceAnalytics;

-- =====================================================
-- 06 - CUSTOMER ANALYSIS
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. TOTAL CUSTOMERS
-- =====================================================

SELECT
    COUNT(*) AS TotalCustomers
FROM Customers;


-- =====================================================
-- 2. CUSTOMERS WHO HAVE PLACED ORDERS
-- =====================================================

SELECT
    COUNT(DISTINCT CustomerID) AS ActiveCustomers
FROM Orders;


-- =====================================================
-- 3. CUSTOMERS WHO HAVE NEVER PLACED AN ORDER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Email,
    c.Country
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;


-- =====================================================
-- 4. NUMBER OF ORDERS PER CUSTOMER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalOrders DESC;


-- =====================================================
-- 5. TOTAL SPENDING PER CUSTOMER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalSpent DESC;


-- =====================================================
-- 6. TOP 10 CUSTOMERS BY SPENDING
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalSpent DESC
LIMIT 10;


-- =====================================================
-- 7. AVERAGE ORDER VALUE PER CUSTOMER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    ROUND(
        SUM(oi.Quantity * oi.UnitPrice)
        / COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY AverageOrderValue DESC;


-- =====================================================
-- 8. REPEAT CUSTOMERS
-- Customers with more than one order
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING COUNT(o.OrderID) > 1
ORDER BY TotalOrders DESC;


-- =====================================================
-- 9. HIGH-VALUE CUSTOMERS
-- Customers who spent more than 5000
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING TotalSpent > 5000
ORDER BY TotalSpent DESC;


-- =====================================================
-- 10. CUSTOMER SEGMENTATION
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent,

    CASE
        WHEN SUM(oi.Quantity * oi.UnitPrice) >= 5000
            THEN 'High Value Customer'

        WHEN SUM(oi.Quantity * oi.UnitPrice) >= 2000
            THEN 'Medium Value Customer'

        ELSE 'Low Value Customer'
    END AS CustomerSegment

FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY TotalSpent DESC;


-- =====================================================
-- 11. NUMBER OF CUSTOMERS IN EACH SEGMENT
-- =====================================================

SELECT
    CustomerSegment,
    COUNT(*) AS TotalCustomers
FROM
(
    SELECT
        c.CustomerID,

        CASE
            WHEN SUM(oi.Quantity * oi.UnitPrice) >= 5000
                THEN 'High Value Customer'

            WHEN SUM(oi.Quantity * oi.UnitPrice) >= 2000
                THEN 'Medium Value Customer'

            ELSE 'Low Value Customer'
        END AS CustomerSegment

    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY c.CustomerID
) AS CustomerSegments
GROUP BY CustomerSegment
ORDER BY TotalCustomers DESC;


-- =====================================================
-- 12. CUSTOMER SPENDING BY COUNTRY
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
-- 13. CUSTOMER SPENDING BY GENDER
-- =====================================================

SELECT
    c.Gender,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY c.Gender
ORDER BY TotalSpent DESC;


-- =====================================================
-- 14. FIRST AND LAST ORDER OF EACH CUSTOMER
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MIN(o.OrderDate) AS FirstOrderDate,
    MAX(o.OrderDate) AS LastOrderDate
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY FirstOrderDate;


-- =====================================================
-- 15. CUSTOMER ORDER FREQUENCY
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    CASE
        WHEN COUNT(DISTINCT o.OrderID) >= 3
            THEN 'Frequent Customer'

        WHEN COUNT(DISTINCT o.OrderID) = 2
            THEN 'Repeat Customer'

        ELSE 'One-Time Customer'
    END AS CustomerType

FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY TotalOrders DESC;


-- =====================================================
-- 16. MOST RECENT CUSTOMERS
-- =====================================================

SELECT
    CustomerID,
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    Country,
    RegistrationDate
FROM Customers
ORDER BY RegistrationDate DESC
LIMIT 10;


-- =====================================================
-- 17. CUSTOMER LIFETIME SALES
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Country,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS LifetimeValue
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country
ORDER BY LifetimeValue DESC;


-- =====================================================
-- 18. CUSTOMER RANKING BY SPENDING
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent,
    RANK() OVER (
        ORDER BY TotalSpent DESC
    ) AS CustomerRank
FROM CustomerSales
ORDER BY CustomerRank;


-- =====================================================
-- 19. TOP 3 CUSTOMERS
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent
FROM CustomerSales
ORDER BY TotalSpent DESC
LIMIT 3;


-- =====================================================
-- 20. CUSTOMER SALES WITH AVERAGE COMPARISON
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent,
    ROUND(
        AVG(TotalSpent) OVER (),
        2
    ) AS AverageCustomerSpending,

    CASE
        WHEN TotalSpent > AVG(TotalSpent) OVER ()
            THEN 'Above Average'

        ELSE 'Below Average'
    END AS SpendingComparison

FROM CustomerSales
ORDER BY TotalSpent DESC;


-- =====================================================
-- 21. CUSTOMER SALES PERCENTAGE OF TOTAL SALES
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent,

    ROUND(
        TotalSpent /
        SUM(TotalSpent) OVER () * 100,
        2
    ) AS PercentageOfTotalSales

FROM CustomerSales
ORDER BY PercentageOfTotalSales DESC;


-- =====================================================
-- 22. CUSTOMER SUMMARY
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Gender,
    c.City,
    c.Country,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Gender,
    c.City,
    c.Country
ORDER BY TotalSpent DESC;