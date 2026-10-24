USE EcommerceAnalytics;

-- =====================================================
-- 02 - CREATE TABLES
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. CUSTOMERS TABLE
-- =====================================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50),
    RegistrationDate DATE
);


-- =====================================================
-- 2. PRODUCTS TABLE
-- =====================================================

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    CostPrice DECIMAL(10,2),
    StockQuantity INT
);


-- =====================================================
-- 3. ORDERS TABLE
-- =====================================================

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE,
    OrderStatus VARCHAR(30),
    PaymentMethod VARCHAR(30),
    ShippingCity VARCHAR(50),
    ShippingCountry VARCHAR(50),

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);


-- =====================================================
-- 4. ORDER ITEMS TABLE
-- =====================================================

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

