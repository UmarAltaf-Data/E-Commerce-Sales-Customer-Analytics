USE EcommerceAnalytics;

-- =====================================================
-- 07 - PRODUCT ANALYSIS
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. TOTAL PRODUCTS
-- =====================================================

SELECT
    COUNT(*) AS TotalProducts
FROM Products;


-- =====================================================
-- 2. PRODUCTS BY CATEGORY
-- =====================================================

SELECT
    Category,
    COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category
ORDER BY TotalProducts DESC;


-- =====================================================
-- 3. PRODUCTS BY SUBCATEGORY
-- =====================================================

SELECT
    SubCategory,
    COUNT(*) AS TotalProducts
FROM Products
GROUP BY SubCategory
ORDER BY TotalProducts DESC;


-- =====================================================
-- 4. PRODUCT PRICE ANALYSIS
-- =====================================================

SELECT
    MIN(UnitPrice) AS LowestPrice,
    MAX(UnitPrice) AS HighestPrice,
    ROUND(AVG(UnitPrice), 2) AS AveragePrice
FROM Products;


-- =====================================================
-- 5. PRODUCT COST ANALYSIS
-- =====================================================

SELECT
    MIN(CostPrice) AS LowestCost,
    MAX(CostPrice) AS HighestCost,
    ROUND(AVG(CostPrice), 2) AS AverageCost
FROM Products;


-- =====================================================
-- 6. PROFIT PER UNIT
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice,
    CostPrice,
    (UnitPrice - CostPrice) AS ProfitPerUnit
FROM Products
ORDER BY ProfitPerUnit DESC;


-- =====================================================
-- 7. PROFIT MARGIN % PER PRODUCT
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice,
    CostPrice,
    ROUND(
        ((UnitPrice - CostPrice) / UnitPrice) * 100,
        2
    ) AS ProfitMarginPercentage
FROM Products
ORDER BY ProfitMarginPercentage DESC;


-- =====================================================
-- 8. TOTAL QUANTITY SOLD BY PRODUCT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY TotalQuantitySold DESC;


-- =====================================================
-- 9. TOTAL SALES BY PRODUCT
-- =====================================================

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
ORDER BY TotalSales DESC;


-- =====================================================
-- 10. TOP 10 PRODUCTS BY SALES
-- =====================================================

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
ORDER BY TotalSales DESC
LIMIT 10;


-- =====================================================
-- 11. TOP 10 PRODUCTS BY QUANTITY SOLD
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY TotalQuantitySold DESC
LIMIT 10;


-- =====================================================
-- 12. PRODUCT PROFIT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS QuantitySold,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    SUM(
        oi.Quantity * (oi.UnitPrice - p.CostPrice)
    ) AS TotalProfit

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY TotalProfit DESC;


-- =====================================================
-- 13. TOP 10 PRODUCTS BY PROFIT
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    SUM(
        oi.Quantity * (oi.UnitPrice - p.CostPrice)
    ) AS TotalProfit

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY TotalProfit DESC
LIMIT 10;


-- =====================================================
-- 14. PRODUCT SALES + PROFIT + MARGIN
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    SUM(oi.Quantity) AS QuantitySold,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    SUM(
        oi.Quantity * (oi.UnitPrice - p.CostPrice)
    ) AS TotalProfit,

    ROUND(
        SUM(
            oi.Quantity * (oi.UnitPrice - p.CostPrice)
        )
        /
        SUM(oi.Quantity * oi.UnitPrice)
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

ORDER BY TotalProfit DESC;


-- =====================================================
-- 15. SALES BY CATEGORY
-- =====================================================

SELECT
    p.Category,

    SUM(oi.Quantity) AS QuantitySold,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY p.Category

ORDER BY TotalSales DESC;


-- =====================================================
-- 16. PROFIT BY CATEGORY
-- =====================================================

SELECT
    p.Category,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    SUM(
        oi.Quantity * (oi.UnitPrice - p.CostPrice)
    ) AS TotalProfit

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY p.Category

ORDER BY TotalProfit DESC;


-- =====================================================
-- 17. CATEGORY PROFIT MARGIN
-- =====================================================

SELECT
    p.Category,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    SUM(
        oi.Quantity * (oi.UnitPrice - p.CostPrice)
    ) AS TotalProfit,

    ROUND(
        SUM(
            oi.Quantity * (oi.UnitPrice - p.CostPrice)
        )
        /
        SUM(oi.Quantity * oi.UnitPrice)
        * 100,
        2
    ) AS ProfitMarginPercentage

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY p.Category

ORDER BY ProfitMarginPercentage DESC;


-- =====================================================
-- 18. PRODUCTS WITH LOW STOCK
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
-- 19. PRODUCTS WITH HIGH STOCK
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    StockQuantity
FROM Products
WHERE StockQuantity > 80
ORDER BY StockQuantity DESC;


-- =====================================================
-- 20. PRODUCTS NEVER SOLD
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
-- 21. INVENTORY VALUE
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    StockQuantity,
    CostPrice,

    (StockQuantity * CostPrice) AS InventoryCostValue

FROM Products

ORDER BY InventoryCostValue DESC;


-- =====================================================
-- 22. TOTAL INVENTORY VALUE
-- =====================================================

SELECT
    SUM(StockQuantity * CostPrice) AS TotalInventoryCost
FROM Products;


-- =====================================================
-- 23. POTENTIAL INVENTORY SALES VALUE
-- =====================================================

SELECT
    SUM(StockQuantity * UnitPrice) AS PotentialSalesValue
FROM Products;


-- =====================================================
-- 24. PRODUCT PERFORMANCE CLASSIFICATION
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,

    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    CASE
        WHEN SUM(oi.Quantity * oi.UnitPrice) >= 5000
            THEN 'High Performer'

        WHEN SUM(oi.Quantity * oi.UnitPrice) >= 2000
            THEN 'Medium Performer'

        ELSE 'Low Performer'
    END AS PerformanceCategory

FROM Products p
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category

ORDER BY TotalSales DESC;


-- =====================================================
-- 25. NUMBER OF PRODUCTS BY PERFORMANCE
-- =====================================================

SELECT
    PerformanceCategory,
    COUNT(*) AS TotalProducts
FROM
(
    SELECT
        p.ProductID,

        CASE
            WHEN SUM(oi.Quantity * oi.UnitPrice) >= 5000
                THEN 'High Performer'

            WHEN SUM(oi.Quantity * oi.UnitPrice) >= 2000
                THEN 'Medium Performer'

            ELSE 'Low Performer'
        END AS PerformanceCategory

    FROM Products p
    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID

    GROUP BY p.ProductID
) AS ProductPerformance

GROUP BY PerformanceCategory
ORDER BY TotalProducts DESC;


-- =====================================================
-- 26. PRODUCT RANKING BY SALES
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
    ) AS SalesRank

FROM ProductSales

ORDER BY SalesRank;


-- =====================================================
-- 27. PRODUCT RANKING WITHIN EACH CATEGORY
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
-- 28. TOP 3 PRODUCTS FROM EACH CATEGORY
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
-- 29. PRODUCT CONTRIBUTION TO TOTAL SALES
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

    ROUND(
        TotalSales /
        SUM(TotalSales) OVER () * 100,
        2
    ) AS SalesContributionPercentage

FROM ProductSales

ORDER BY SalesContributionPercentage DESC;


-- =====================================================
-- 30. FINAL PRODUCT SUMMARY
-- =====================================================

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.SubCategory,
    p.UnitPrice,
    p.CostPrice,
    p.StockQuantity,

    COALESCE(SUM(oi.Quantity), 0) AS QuantitySold,

    COALESCE(
        SUM(oi.Quantity * oi.UnitPrice),
        0
    ) AS TotalSales,

    COALESCE(
        SUM(
            oi.Quantity * (oi.UnitPrice - p.CostPrice)
        ),
        0
    ) AS TotalProfit

FROM Products p

LEFT JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category,
    p.SubCategory,
    p.UnitPrice,
    p.CostPrice,
    p.StockQuantity

ORDER BY TotalSales DESC;