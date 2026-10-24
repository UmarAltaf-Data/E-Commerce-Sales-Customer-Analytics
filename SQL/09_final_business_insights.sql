USE EcommerceAnalytics;

-- =====================================================
-- 09 - FINAL BUSINESS INSIGHTS
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. OVERALL BUSINESS KPI
-- =====================================================

SELECT
    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    COUNT(DISTINCT o.CustomerID) AS TotalCustomers,

    SUM(oi.Quantity) AS TotalUnitsSold,

    ROUND(
        SUM(oi.Quantity * oi.UnitPrice),
        2
    ) AS TotalRevenue,

    ROUND(
        SUM(oi.Quantity * oi.UnitPrice)
        / COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID;


-- =====================================================
-- 2. TOTAL PROFIT
-- =====================================================

SELECT
    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS TotalProfit

FROM OrderItems oi

JOIN Products p
    ON oi.ProductID = p.ProductID;


-- =====================================================
-- 3. OVERALL PROFIT MARGIN
-- =====================================================

SELECT
    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        )
        /
        SUM(
            oi.Quantity * oi.UnitPrice
        )
        * 100,
        2
    ) AS OverallProfitMarginPercentage

FROM OrderItems oi

JOIN Products p
    ON oi.ProductID = p.ProductID;


-- =====================================================
-- 4. BEST SELLING PRODUCT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    SUM(oi.Quantity) AS QuantitySold,

    ROUND(
        SUM(oi.Quantity * oi.UnitPrice),
        2
    ) AS TotalSales

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY TotalSales DESC

LIMIT 1;


-- =====================================================
-- 5. MOST PROFITABLE PRODUCT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS TotalProfit

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY TotalProfit DESC

LIMIT 1;


-- =====================================================
-- 6. BEST PERFORMING CATEGORY BY SALES
-- =====================================================

SELECT
    p.Category,

    SUM(
        oi.Quantity * oi.UnitPrice
    ) AS TotalSales

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY p.Category

ORDER BY TotalSales DESC

LIMIT 1;


-- =====================================================
-- 7. MOST PROFITABLE CATEGORY
-- =====================================================

SELECT
    p.Category,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS TotalProfit

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY p.Category

ORDER BY TotalProfit DESC

LIMIT 1;


-- =====================================================
-- 8. TOP 10 CUSTOMERS
-- =====================================================

SELECT
    c.CustomerID,

    CONCAT(
        c.FirstName,
        ' ',
        c.LastName
    ) AS CustomerName,

    c.Country,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalSpent

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

ORDER BY TotalSpent DESC

LIMIT 10;


-- =====================================================
-- 9. REPEAT CUSTOMER RATE
-- =====================================================

WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        COUNT(DISTINCT OrderID) AS TotalOrders

    FROM Orders

    GROUP BY CustomerID
),

CustomerSummary AS
(
    SELECT
        COUNT(*) AS TotalCustomers,

        SUM(
            CASE
                WHEN TotalOrders > 1
                THEN 1
                ELSE 0
            END
        ) AS RepeatCustomers

    FROM CustomerOrders
)

SELECT
    TotalCustomers,
    RepeatCustomers,

    ROUND(
        RepeatCustomers
        / TotalCustomers
        * 100,
        2
    ) AS RepeatCustomerRatePercentage

FROM CustomerSummary;


-- =====================================================
-- 10. ONE-TIME CUSTOMER RATE
-- =====================================================

WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        COUNT(DISTINCT OrderID) AS TotalOrders

    FROM Orders

    GROUP BY CustomerID
)

SELECT

    COUNT(*) AS TotalCustomers,

    SUM(
        CASE
            WHEN TotalOrders = 1
            THEN 1
            ELSE 0
        END
    ) AS OneTimeCustomers,

    ROUND(
        SUM(
            CASE
                WHEN TotalOrders = 1
                THEN 1
                ELSE 0
            END
        )
        / COUNT(*)
        * 100,
        2
    ) AS OneTimeCustomerRatePercentage

FROM CustomerOrders;


-- =====================================================
-- 11. SALES BY COUNTRY
-- =====================================================

SELECT
    o.ShippingCountry AS Country,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    COUNT(DISTINCT o.CustomerID) AS TotalCustomers,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY o.ShippingCountry

ORDER BY TotalSales DESC;


-- =====================================================
-- 12. SALES CONTRIBUTION BY COUNTRY
-- =====================================================

WITH CountrySales AS
(
    SELECT
        o.ShippingCountry AS Country,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSales

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY o.ShippingCountry
)

SELECT
    Country,
    TotalSales,

    ROUND(
        TotalSales
        /
        SUM(TotalSales) OVER ()
        * 100,
        2
    ) AS SalesContributionPercentage

FROM CountrySales

ORDER BY SalesContributionPercentage DESC;


-- =====================================================
-- 13. BEST PAYMENT METHOD
-- =====================================================

SELECT
    o.PaymentMethod,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalSales,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        )
        /
        COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY o.PaymentMethod

ORDER BY TotalSales DESC

LIMIT 1;


-- =====================================================
-- 14. MONTH WITH HIGHEST SALES
-- =====================================================

SELECT
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)

ORDER BY TotalSales DESC

LIMIT 1;


-- =====================================================
-- 15. LOW STOCK PRODUCTS
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    StockQuantity

FROM Products

WHERE StockQuantity < 30

ORDER BY StockQuantity ASC;


-- =====================================================
-- 16. UNSOLD PRODUCTS
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.StockQuantity

FROM Products p

LEFT JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

WHERE oi.ProductID IS NULL

ORDER BY p.StockQuantity DESC;


-- =====================================================
-- 17. HIGH VALUE CUSTOMERS
-- =====================================================

SELECT
    c.CustomerID,

    CONCAT(
        c.FirstName,
        ' ',
        c.LastName
    ) AS CustomerName,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalSpent

FROM Customers c

JOIN Orders o
    ON c.CustomerID = o.CustomerID

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

HAVING TotalSpent >= 5000

ORDER BY TotalSpent DESC;


-- =====================================================
-- 18. PRODUCT PERFORMANCE SUMMARY
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    SUM(oi.Quantity) AS UnitsSold,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS Revenue,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS Profit,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        )
        /
        SUM(
            oi.Quantity * oi.UnitPrice
        )
        * 100,
        2
    ) AS ProfitMarginPercentage

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY Revenue DESC;


-- =====================================================
-- 19. TOP 5 PRODUCTS BY REVENUE
-- =====================================================

SELECT
    p.ProductName,
    p.Category,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS Revenue

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY Revenue DESC

LIMIT 5;


-- =====================================================
-- 20. TOP 5 PRODUCTS BY PROFIT
-- =====================================================

SELECT
    p.ProductName,
    p.Category,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS Profit

FROM Products p

JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY Profit DESC

LIMIT 5;


-- =====================================================
-- 21. CUSTOMER SEGMENT SUMMARY
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSpent

    FROM Customers c

    JOIN Orders o
        ON c.CustomerID = o.CustomerID

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY c.CustomerID
)

SELECT

    CASE
        WHEN TotalSpent >= 5000
            THEN 'High Value'

        WHEN TotalSpent >= 2000
            THEN 'Medium Value'

        ELSE 'Low Value'

    END AS CustomerSegment,

    COUNT(*) AS TotalCustomers,

    ROUND(
        AVG(TotalSpent),
        2
    ) AS AverageCustomerSpending,

    ROUND(
        SUM(TotalSpent),
        2
    ) AS SegmentRevenue

FROM CustomerSales

GROUP BY CustomerSegment

ORDER BY SegmentRevenue DESC;


-- =====================================================
-- 22. FINAL EXECUTIVE DASHBOARD KPI
-- =====================================================

SELECT

    COUNT(DISTINCT o.OrderID)
        AS TotalOrders,

    COUNT(DISTINCT o.CustomerID)
        AS TotalCustomers,

    SUM(oi.Quantity)
        AS TotalUnitsSold,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        ),
        2
    ) AS TotalRevenue,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ),
        2
    ) AS TotalProfit,

    ROUND(
        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        )
        /
        SUM(
            oi.Quantity * oi.UnitPrice
        )
        * 100,
        2
    ) AS ProfitMarginPercentage,

    ROUND(
        SUM(
            oi.Quantity * oi.UnitPrice
        )
        /
        COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

JOIN Products p
    ON oi.ProductID = p.ProductID;


-- =====================================================
-- 23. FINAL BUSINESS PERFORMANCE TABLE
-- =====================================================

WITH ProductMetrics AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        SUM(oi.Quantity) AS UnitsSold,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS Revenue,

        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ) AS Profit

    FROM Products p

    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)

SELECT
    ProductID,
    ProductName,
    Category,
    UnitsSold,

    ROUND(Revenue, 2) AS Revenue,

    ROUND(Profit, 2) AS Profit,

    ROUND(
        Profit / Revenue * 100,
        2
    ) AS ProfitMarginPercentage,

    RANK() OVER (
        ORDER BY Revenue DESC
    ) AS RevenueRank,

    RANK() OVER (
        ORDER BY Profit DESC
    ) AS ProfitRank

FROM ProductMetrics

ORDER BY RevenueRank;


-- =====================================================
-- 24. FINAL CUSTOMER PERFORMANCE TABLE
-- =====================================================

WITH CustomerMetrics AS
(
    SELECT
        c.CustomerID,

        CONCAT(
            c.FirstName,
            ' ',
            c.LastName
        ) AS CustomerName,

        c.Country,

        COUNT(DISTINCT o.OrderID) AS TotalOrders,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSpent

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
)

SELECT
    CustomerID,
    CustomerName,
    Country,
    TotalOrders,

    ROUND(TotalSpent, 2) AS TotalSpent,

    ROUND(
        TotalSpent
        /
        TotalOrders,
        2
    ) AS AverageOrderValue,

    RANK() OVER (
        ORDER BY TotalSpent DESC
    ) AS CustomerRank,

    CASE
        WHEN TotalSpent >= 5000
            THEN 'High Value'

        WHEN TotalSpent >= 2000
            THEN 'Medium Value'

        ELSE 'Low Value'

    END AS CustomerSegment

FROM CustomerMetrics

ORDER BY CustomerRank;