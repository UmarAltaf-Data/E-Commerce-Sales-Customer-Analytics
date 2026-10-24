USE EcommerceAnalytics;


-- =====================================================
-- 04 - DATA EXPLORATION
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. CHECK ALL TABLES
-- =====================================================

SHOW TABLES;

-- 2. VIEW CUSTOMERS DATA

SELECT *
FROM Customers;

-- 3. VIEW PRODUCTS DATA

SELECT *
FROM Products;

-- 4. VIEW ORDERS DATA

SELECT *
FROM Orders;

-- 5. VIEW ORDER ITEMS DATA

SELECT *
FROM OrderItems;


-- =====================================================
-- 6. COUNT RECORDS IN EACH TABLE
-- =====================================================

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT COUNT(*) AS TotalProducts
FROM Products;

SELECT COUNT(*) AS TotalOrders
FROM Orders;

SELECT COUNT(*) AS TotalOrderItems
FROM OrderItems;


-- =====================================================
-- 7. CUSTOMER EXPLORATION
-- =====================================================

-- Customers by Gender

SELECT
    Gender,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Gender;


-- Customers by Country

SELECT
    Country,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country
ORDER BY TotalCustomers DESC;


-- Customers by City

SELECT
    City,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;


-- =====================================================
-- 8. PRODUCT EXPLORATION
-- =====================================================

-- Products by Category

SELECT
    Category,
    COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category
ORDER BY TotalProducts DESC;


-- Products by SubCategory

SELECT
    SubCategory,
    COUNT(*) AS TotalProducts
FROM Products
GROUP BY SubCategory
ORDER BY TotalProducts DESC;


-- Product Price Range

SELECT
    MIN(UnitPrice) AS LowestPrice,
    MAX(UnitPrice) AS HighestPrice,
    AVG(UnitPrice) AS AveragePrice
FROM Products;


-- Product Stock

SELECT
    MIN(StockQuantity) AS LowestStock,
    MAX(StockQuantity) AS HighestStock,
    AVG(StockQuantity) AS AverageStock
FROM Products;


-- Products with low stock

SELECT
    ProductID,
    ProductName,
    StockQuantity
FROM Products
WHERE StockQuantity < 30
ORDER BY StockQuantity ASC;


-- =====================================================
-- 9. ORDER EXPLORATION
-- =====================================================

-- Orders by Payment Method

SELECT
    PaymentMethod,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY PaymentMethod
ORDER BY TotalOrders DESC;


-- Orders by Status

SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY OrderStatus;


-- Orders by Country

SELECT
    ShippingCountry,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY ShippingCountry
ORDER BY TotalOrders DESC;


-- Orders by City

SELECT
    ShippingCity,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY ShippingCity
ORDER BY TotalOrders DESC;


-- =====================================================
-- 10. ORDER DATE EXPLORATION
-- =====================================================

-- Earliest and Latest Order

SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LatestOrderDate
FROM Orders;


-- Orders by Month

SELECT
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY OrderMonth;


-- Orders by Year

SELECT
    YEAR(OrderDate) AS OrderYear,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate);


-- =====================================================
-- 11. ORDER ITEMS EXPLORATION
-- =====================================================

-- Total Quantity Sold

SELECT
    SUM(Quantity) AS TotalQuantitySold
FROM OrderItems;


-- Average Quantity per Order Item

SELECT
    AVG(Quantity) AS AverageQuantity
FROM OrderItems;


-- Highest Quantity in One Order Item

SELECT
    MAX(Quantity) AS HighestQuantity
FROM OrderItems;


-- =====================================================
-- 12. BASIC SALES CALCULATION
-- =====================================================

-- Total Sales

SELECT
    SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderItems;


-- Average Order Item Value

SELECT
    AVG(Quantity * UnitPrice) AS AverageOrderItemValue
FROM OrderItems;


-- Minimum Order Item Value

SELECT
    MIN(Quantity * UnitPrice) AS MinimumOrderItemValue
FROM OrderItems;


-- Maximum Order Item Value

SELECT
    MAX(Quantity * UnitPrice) AS MaximumOrderItemValue
FROM OrderItems;


-- =====================================================
-- 13. TOP PRODUCTS BY PRICE
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM Products
ORDER BY UnitPrice DESC
LIMIT 10;


-- =====================================================
-- 14. LOWEST PRICED PRODUCTS
-- =====================================================

SELECT
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM Products
ORDER BY UnitPrice ASC
LIMIT 10;


-- =====================================================
-- 15. DATA QUALITY CHECKS
-- =====================================================

-- Check NULL Customer Emails

SELECT *
FROM Customers
WHERE Email IS NULL;


-- Check NULL Product Prices

SELECT *
FROM Products
WHERE UnitPrice IS NULL;


-- Check NULL Order Dates

SELECT *
FROM Orders
WHERE OrderDate IS NULL;


-- Check NULL Order Item Quantity

SELECT *
FROM OrderItems
WHERE Quantity IS NULL;


-- =====================================================
-- 16. CHECK DUPLICATE CUSTOMER EMAILS
-- =====================================================

SELECT
    Email,
    COUNT(*) AS EmailCount
FROM Customers
GROUP BY Email
HAVING COUNT(*) > 1;


-- =====================================================
-- 17. CHECK INVALID QUANTITY
-- =====================================================

SELECT *
FROM OrderItems
WHERE Quantity <= 0;


-- =====================================================
-- 18. CHECK INVALID PRODUCT PRICES
-- =====================================================

SELECT *
FROM Products
WHERE UnitPrice <= 0
   OR CostPrice <= 0;


-- =====================================================
-- 19. CHECK PROFIT MARGIN OF PRODUCTS
-- =====================================================

SELECT
    ProductID,
    ProductName,
    UnitPrice,
    CostPrice,
    (UnitPrice - CostPrice) AS ProfitPerUnit
FROM Products
ORDER BY ProfitPerUnit DESC;


-- =====================================================
-- 20. BASIC PRODUCT PROFIT MARGIN %
-- =====================================================

SELECT
    ProductID,
    ProductName,
    UnitPrice,
    CostPrice,
    ROUND(
        ((UnitPrice - CostPrice) / UnitPrice) * 100,
        2
    ) AS ProfitMarginPercentage
FROM Products
ORDER BY ProfitMarginPercentage DESC;