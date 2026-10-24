USE EcommerceAnalytics;

-- =====================================================
-- 08 - ADVANCED ANALYSIS
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. MONTHLY SALES WITH MONTH-OVER-MONTH GROWTH
-- =====================================================

WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

    FROM Orders o
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    OrderYear,
    OrderMonth,
    TotalSales,

    LAG(TotalSales) OVER (
        ORDER BY OrderYear, OrderMonth
    ) AS PreviousMonthSales,

    ROUND(
        (
            TotalSales
            - LAG(TotalSales) OVER (
                ORDER BY OrderYear, OrderMonth
            )
        )
        /
        NULLIF(
            LAG(TotalSales) OVER (
                ORDER BY OrderYear, OrderMonth
            ),
            0
        ) * 100,
        2
    ) AS MonthOverMonthGrowthPercentage

FROM MonthlySales

ORDER BY
    OrderYear,
    OrderMonth;


-- =====================================================
-- 2. RUNNING TOTAL OF SALES
-- =====================================================

WITH DailySales AS
(
    SELECT
        o.OrderDate,
        SUM(oi.Quantity * oi.UnitPrice) AS DailySales

    FROM Orders o
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY o.OrderDate
)

SELECT
    OrderDate,
    DailySales,

    SUM(DailySales) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS RunningTotalSales

FROM DailySales

ORDER BY OrderDate;


-- =====================================================
-- 3. RUNNING TOTAL BY MONTH
-- =====================================================

WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS MonthlySales

    FROM Orders o
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    OrderYear,
    OrderMonth,
    MonthlySales,

    SUM(MonthlySales) OVER (
        ORDER BY OrderYear, OrderMonth
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS RunningTotalSales

FROM MonthlySales

ORDER BY
    OrderYear,
    OrderMonth;


-- =====================================================
-- 4. MONTHLY SALES RANKING
-- =====================================================

WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

    FROM Orders o
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    OrderYear,
    OrderMonth,
    TotalSales,

    RANK() OVER (
        ORDER BY TotalSales DESC
    ) AS SalesRank

FROM MonthlySales

ORDER BY SalesRank;


-- =====================================================
-- 5. PRODUCT SALES WITH RANKING
-- =====================================================

WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

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
    TotalSales,

    RANK() OVER (
        ORDER BY TotalSales DESC
    ) AS OverallProductRank

FROM ProductSales

ORDER BY OverallProductRank;


-- =====================================================
-- 6. PRODUCT RANK WITHIN CATEGORY
-- =====================================================

WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

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
    TotalSales,

    RANK() OVER (
        PARTITION BY Category
        ORDER BY TotalSales DESC
    ) AS CategoryRank

FROM ProductSales

ORDER BY
    Category,
    CategoryRank;


-- =====================================================
-- 7. TOP 3 PRODUCTS PER CATEGORY
-- =====================================================

WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

    FROM Products p
    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
),

RankedProducts AS
(
    SELECT
        ProductID,
        ProductName,
        Category,
        TotalSales,

        RANK() OVER (
            PARTITION BY Category
            ORDER BY TotalSales DESC
        ) AS CategoryRank

    FROM ProductSales
)

SELECT
    ProductID,
    ProductName,
    Category,
    TotalSales,
    CategoryRank

FROM RankedProducts

WHERE CategoryRank <= 3

ORDER BY
    Category,
    CategoryRank;


-- =====================================================
-- 8. CUSTOMER RANKING BY TOTAL SPENDING
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        c.Country,

        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent

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
    TotalSpent,

    RANK() OVER (
        ORDER BY TotalSpent DESC
    ) AS CustomerRank

FROM CustomerSales

ORDER BY CustomerRank;


-- =====================================================
-- 9. CUSTOMER SPENDING VS AVERAGE
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

    ROUND(
        TotalSpent - AVG(TotalSpent) OVER (),
        2
    ) AS DifferenceFromAverage

FROM CustomerSales

ORDER BY TotalSpent DESC;


-- =====================================================
-- 10. CUSTOMER SALES CONTRIBUTION %
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
        TotalSpent
        /
        SUM(TotalSpent) OVER ()
        * 100,
        2
    ) AS SalesContributionPercentage

FROM CustomerSales

ORDER BY SalesContributionPercentage DESC;


-- =====================================================
-- 11. SALES BY COUNTRY WITH RANKING
-- =====================================================

WITH CountrySales AS
(
    SELECT
        o.ShippingCountry AS Country,

        COUNT(DISTINCT o.OrderID) AS TotalOrders,

        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY o.ShippingCountry
)

SELECT
    Country,
    TotalOrders,
    TotalSales,

    RANK() OVER (
        ORDER BY TotalSales DESC
    ) AS CountrySalesRank

FROM CountrySales

ORDER BY CountrySalesRank;


-- =====================================================
-- 12. CATEGORY SALES WITH PERCENTAGE OF TOTAL
-- =====================================================

WITH CategorySales AS
(
    SELECT
        p.Category,

        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

    FROM Products p

    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    GROUP BY p.Category
)

SELECT
    Category,
    TotalSales,

    ROUND(
        TotalSales
        /
        SUM(TotalSales) OVER ()
        * 100,
        2
    ) AS PercentageOfTotalSales

FROM CategorySales

ORDER BY PercentageOfTotalSales DESC;


-- =====================================================
-- 13. CATEGORY PROFIT ANALYSIS
-- =====================================================

WITH CategoryProfit AS
(
    SELECT
        p.Category,

        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ) AS TotalProfit

    FROM Products p

    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    GROUP BY p.Category
)

SELECT
    Category,
    TotalSales,
    TotalProfit,

    ROUND(
        TotalProfit / TotalSales * 100,
        2
    ) AS ProfitMarginPercentage,

    RANK() OVER (
        ORDER BY TotalProfit DESC
    ) AS ProfitRank

FROM CategoryProfit

ORDER BY ProfitRank;


-- =====================================================
-- 14. ORDER VALUE WITH LAG
-- =====================================================

WITH OrderSales AS
(
    SELECT
        o.OrderID,
        o.OrderDate,

        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        o.OrderID,
        o.OrderDate
)

SELECT
    OrderID,
    OrderDate,
    OrderValue,

    LAG(OrderValue) OVER (
        ORDER BY OrderDate, OrderID
    ) AS PreviousOrderValue,

    LEAD(OrderValue) OVER (
        ORDER BY OrderDate, OrderID
    ) AS NextOrderValue

FROM OrderSales

ORDER BY
    OrderDate,
    OrderID;


-- =====================================================
-- 15. ORDER VALUE DIFFERENCE
-- =====================================================

WITH OrderSales AS
(
    SELECT
        o.OrderID,
        o.OrderDate,

        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        o.OrderID,
        o.OrderDate
),

OrderComparison AS
(
    SELECT
        OrderID,
        OrderDate,
        OrderValue,

        LAG(OrderValue) OVER (
            ORDER BY OrderDate, OrderID
        ) AS PreviousOrderValue

    FROM OrderSales
)

SELECT
    OrderID,
    OrderDate,
    OrderValue,
    PreviousOrderValue,

    ROUND(
        OrderValue - PreviousOrderValue,
        2
    ) AS DifferenceFromPreviousOrder

FROM OrderComparison

ORDER BY
    OrderDate,
    OrderID;


-- =====================================================
-- 16. CUSTOMER FIRST AND LAST PURCHASE
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,

    MIN(o.OrderDate) AS FirstPurchaseDate,

    MAX(o.OrderDate) AS LastPurchaseDate

FROM Customers c

JOIN Orders o
    ON c.CustomerID = o.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY FirstPurchaseDate;


-- =====================================================
-- 17. DAYS BETWEEN FIRST AND LAST PURCHASE
-- =====================================================

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,

    MIN(o.OrderDate) AS FirstPurchaseDate,

    MAX(o.OrderDate) AS LastPurchaseDate,

    DATEDIFF(
        MAX(o.OrderDate),
        MIN(o.OrderDate)
    ) AS CustomerLifetimeDays

FROM Customers c

JOIN Orders o
    ON c.CustomerID = o.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY CustomerLifetimeDays DESC;


-- =====================================================
-- 18. CUSTOMER ORDER FREQUENCY
-- =====================================================

WITH CustomerOrders AS
(
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
)

SELECT
    CustomerID,
    CustomerName,
    TotalOrders,
    TotalSpent,

    CASE
        WHEN TotalOrders >= 5
            THEN 'Very Frequent'

        WHEN TotalOrders >= 3
            THEN 'Frequent'

        WHEN TotalOrders = 2
            THEN 'Repeat'

        ELSE 'One-Time'

    END AS CustomerFrequency

FROM CustomerOrders

ORDER BY TotalOrders DESC;


-- =====================================================
-- 19. CUSTOMER VALUE SEGMENTATION
-- =====================================================

WITH CustomerSales AS
(
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
)

SELECT
    CustomerID,
    CustomerName,
    TotalOrders,
    TotalSpent,

    CASE

        WHEN TotalSpent >= 10000
             AND TotalOrders >= 3
            THEN 'VIP Customer'

        WHEN TotalSpent >= 5000
            THEN 'High Value Customer'

        WHEN TotalSpent >= 2000
            THEN 'Medium Value Customer'

        ELSE 'Low Value Customer'

    END AS CustomerSegment

FROM CustomerSales

ORDER BY TotalSpent DESC;


-- =====================================================
-- 20. PRODUCT SALES GROWTH USING LAG
-- =====================================================

WITH MonthlyProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,

        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS MonthlySales

    FROM Products p

    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    JOIN Orders o
        ON oi.OrderID = o.OrderID

    GROUP BY
        p.ProductID,
        p.ProductName,
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    ProductID,
    ProductName,
    OrderYear,
    OrderMonth,
    MonthlySales,

    LAG(MonthlySales) OVER (
        PARTITION BY ProductID
        ORDER BY OrderYear, OrderMonth
    ) AS PreviousMonthSales

FROM MonthlyProductSales

ORDER BY
    ProductID,
    OrderYear,
    OrderMonth;


-- =====================================================
-- 21. MONTHLY PRODUCT GROWTH %
-- =====================================================

WITH MonthlyProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,

        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS MonthlySales

    FROM Products p

    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    JOIN Orders o
        ON oi.OrderID = o.OrderID

    GROUP BY
        p.ProductID,
        p.ProductName,
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
),

ProductGrowth AS
(
    SELECT
        ProductID,
        ProductName,
        OrderYear,
        OrderMonth,
        MonthlySales,

        LAG(MonthlySales) OVER (
            PARTITION BY ProductID
            ORDER BY OrderYear, OrderMonth
        ) AS PreviousMonthSales

    FROM MonthlyProductSales
)

SELECT
    ProductID,
    ProductName,
    OrderYear,
    OrderMonth,
    MonthlySales,
    PreviousMonthSales,

    ROUND(
        (
            MonthlySales - PreviousMonthSales
        )
        /
        NULLIF(PreviousMonthSales, 0)
        * 100,
        2
    ) AS GrowthPercentage

FROM ProductGrowth

ORDER BY
    ProductID,
    OrderYear,
    OrderMonth;


-- =====================================================
-- 22. SALES PERFORMANCE BY MONTH
-- =====================================================

WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,

        COUNT(DISTINCT o.OrderID) AS TotalOrders,

        SUM(oi.Quantity) AS TotalQuantity,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSales

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    OrderYear,
    OrderMonth,
    TotalOrders,
    TotalQuantity,
    TotalSales,

    ROUND(
        TotalSales / TotalOrders,
        2
    ) AS AverageOrderValue,

    RANK() OVER (
        ORDER BY TotalSales DESC
    ) AS MonthlySalesRank

FROM MonthlySales

ORDER BY
    OrderYear,
    OrderMonth;


-- =====================================================
-- 23. QUARTERLY SALES ANALYSIS
-- =====================================================

SELECT
    YEAR(o.OrderDate) AS OrderYear,

    QUARTER(o.OrderDate) AS QuarterNumber,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    SUM(oi.Quantity) AS TotalQuantity,

    SUM(
        oi.Quantity * oi.UnitPrice
    ) AS TotalSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY
    YEAR(o.OrderDate),
    QUARTER(o.OrderDate)

ORDER BY
    OrderYear,
    QuarterNumber;


-- =====================================================
-- 24. SALES BY DAY OF WEEK
-- =====================================================

SELECT
    DAYNAME(o.OrderDate) AS DayOfWeek,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    SUM(
        oi.Quantity * oi.UnitPrice
    ) AS TotalSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY DAYNAME(o.OrderDate)

ORDER BY TotalSales DESC;


-- =====================================================
-- 25. PAYMENT METHOD PERFORMANCE
-- =====================================================

SELECT
    o.PaymentMethod,

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    SUM(
        oi.Quantity * oi.UnitPrice
    ) AS TotalSales,

    ROUND(
        SUM(oi.Quantity * oi.UnitPrice)
        /
        COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

GROUP BY o.PaymentMethod

ORDER BY TotalSales DESC;


-- =====================================================
-- 26. HIGH VALUE ORDERS
-- =====================================================

WITH OrderSales AS
(
    SELECT
        o.OrderID,
        o.CustomerID,
        o.OrderDate,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS OrderValue

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    GROUP BY
        o.OrderID,
        o.CustomerID,
        o.OrderDate
)

SELECT
    OrderID,
    CustomerID,
    OrderDate,
    OrderValue,

    CASE
        WHEN OrderValue >= 5000
            THEN 'Very High Value'

        WHEN OrderValue >= 3000
            THEN 'High Value'

        WHEN OrderValue >= 1000
            THEN 'Medium Value'

        ELSE 'Standard Order'

    END AS OrderCategory

FROM OrderSales

ORDER BY OrderValue DESC;


-- =====================================================
-- 27. PERCENTILE-STYLE CUSTOMER ANALYSIS USING NTILE
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,

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
        c.LastName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent,

    NTILE(4) OVER (
        ORDER BY TotalSpent DESC
    ) AS CustomerQuartile

FROM CustomerSales

ORDER BY CustomerQuartile, TotalSpent DESC;


-- =====================================================
-- 28. PRODUCT QUARTILES BY SALES
-- =====================================================

WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSales

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
    TotalSales,

    NTILE(4) OVER (
        ORDER BY TotalSales DESC
    ) AS SalesQuartile

FROM ProductSales

ORDER BY SalesQuartile, TotalSales DESC;


-- =====================================================
-- 29. FINAL BUSINESS PERFORMANCE SUMMARY
-- =====================================================

WITH ProductPerformance AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

        SUM(oi.Quantity) AS QuantitySold,

        SUM(
            oi.Quantity * oi.UnitPrice
        ) AS TotalSales,

        SUM(
            oi.Quantity *
            (oi.UnitPrice - p.CostPrice)
        ) AS TotalProfit

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
    QuantitySold,
    TotalSales,
    TotalProfit,

    ROUND(
        TotalProfit / TotalSales * 100,
        2
    ) AS ProfitMarginPercentage,

    RANK() OVER (
        ORDER BY TotalSales DESC
    ) AS SalesRank,

    RANK() OVER (
        ORDER BY TotalProfit DESC
    ) AS ProfitRank

FROM ProductPerformance

ORDER BY SalesRank;


-- =====================================================
-- 30. TOP BUSINESS METRICS
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
        /
        COUNT(DISTINCT o.OrderID),
        2
    ) AS AverageOrderValue

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID;