USE EcommerceAnalytics;


-- =====================================================
-- 03 - INSERT DATA
-- E-Commerce Sales & Customer Analytics
-- =====================================================


-- =====================================================
-- 1. CUSTOMERS DATA
-- =====================================================

INSERT INTO Customers
(CustomerID, FirstName, LastName, Gender, Email, Phone, City, Country, RegistrationDate)
VALUES
(1, 'Ali', 'Khan', 'Male', 'ali.khan@gmail.com', '55510001', 'Doha', 'Qatar', '2025-01-05'),
(2, 'Ahmed', 'Raza', 'Male', 'ahmed.raza@gmail.com', '55510002', 'Dubai', 'UAE', '2025-01-10'),
(3, 'Sara', 'Ahmed', 'Female', 'sara.ahmed@gmail.com', '55510003', 'Doha', 'Qatar', '2025-01-15'),
(4, 'Ayesha', 'Malik', 'Female', 'ayesha.malik@gmail.com', '55510004', 'Abu Dhabi', 'UAE', '2025-01-20'),
(5, 'Usman', 'Ali', 'Male', 'usman.ali@gmail.com', '55510005', 'Doha', 'Qatar', '2025-01-25'),
(6, 'Fatima', 'Khan', 'Female', 'fatima.khan@gmail.com', '55510006', 'Dubai', 'UAE', '2025-02-02'),
(7, 'Hassan', 'Javed', 'Male', 'hassan.javed@gmail.com', '55510007', 'Doha', 'Qatar', '2025-02-08'),
(8, 'Zainab', 'Iqbal', 'Female', 'zainab.iqbal@gmail.com', '55510008', 'Abu Dhabi', 'UAE', '2025-02-12'),
(9, 'Bilal', 'Ahmed', 'Male', 'bilal.ahmed@gmail.com', '55510009', 'Dubai', 'UAE', '2025-02-18'),
(10, 'Hina', 'Shah', 'Female', 'hina.shah@gmail.com', '55510010', 'Doha', 'Qatar', '2025-02-22'),
(11, 'Omar', 'Farooq', 'Male', 'omar.farooq@gmail.com', '55510011', 'Riyadh', 'Saudi Arabia', '2025-03-01'),
(12, 'Maryam', 'Siddiqui', 'Female', 'maryam.siddiqui@gmail.com', '55510012', 'Jeddah', 'Saudi Arabia', '2025-03-05'),
(13, 'Hamza', 'Tariq', 'Male', 'hamza.tariq@gmail.com', '55510013', 'Doha', 'Qatar', '2025-03-10'),
(14, 'Noor', 'Hassan', 'Female', 'noor.hassan@gmail.com', '55510014', 'Dubai', 'UAE', '2025-03-15'),
(15, 'Saad', 'Butt', 'Male', 'saad.butt@gmail.com', '55510015', 'Abu Dhabi', 'UAE', '2025-03-20'),
(16, 'Maha', 'Aslam', 'Female', 'maha.aslam@gmail.com', '55510016', 'Doha', 'Qatar', '2025-03-25'),
(17, 'Fahad', 'Sheikh', 'Male', 'fahad.sheikh@gmail.com', '55510017', 'Riyadh', 'Saudi Arabia', '2025-04-01'),
(18, 'Iqra', 'Nadeem', 'Female', 'iqra.nadeem@gmail.com', '55510018', 'Dubai', 'UAE', '2025-04-05'),
(19, 'Waqas', 'Hussain', 'Male', 'waqas.hussain@gmail.com', '55510019', 'Doha', 'Qatar', '2025-04-10'),
(20, 'Sana', 'Rashid', 'Female', 'sana.rashid@gmail.com', '55510020', 'Jeddah', 'Saudi Arabia', '2025-04-15'),
(21, 'Talha', 'Imran', 'Male', 'talha.imran@gmail.com', '55510021', 'Dubai', 'UAE', '2025-05-01'),
(22, 'Amna', 'Khalid', 'Female', 'amna.khalid@gmail.com', '55510022', 'Doha', 'Qatar', '2025-05-05'),
(23, 'Danish', 'Akram', 'Male', 'danish.akram@gmail.com', '55510023', 'Abu Dhabi', 'UAE', '2025-05-10'),
(24, 'Laiba', 'Asif', 'Female', 'laiba.asif@gmail.com', '55510024', 'Riyadh', 'Saudi Arabia', '2025-05-15'),
(25, 'Arslan', 'Mehmood', 'Male', 'arslan.mehmood@gmail.com', '55510025', 'Doha', 'Qatar', '2025-05-20'),
(26, 'Mehwish', 'Zahid', 'Female', 'mehwish.zahid@gmail.com', '55510026', 'Dubai', 'UAE', '2025-06-01'),
(27, 'Rehan', 'Qureshi', 'Male', 'rehan.qureshi@gmail.com', '55510027', 'Jeddah', 'Saudi Arabia', '2025-06-05'),
(28, 'Anum', 'Waheed', 'Female', 'anum.waheed@gmail.com', '55510028', 'Doha', 'Qatar', '2025-06-10'),
(29, 'Yasir', 'Mahmood', 'Male', 'yasir.mahmood@gmail.com', '55510029', 'Dubai', 'UAE', '2025-06-15'),
(30, 'Eman', 'Rauf', 'Female', 'eman.rauf@gmail.com', '55510030', 'Abu Dhabi', 'UAE', '2025-06-20');


-- =====================================================
-- 2. PRODUCTS DATA
-- =====================================================

INSERT INTO Products
(ProductID, ProductName, Category, SubCategory, UnitPrice, CostPrice, StockQuantity)
VALUES
(101, 'Laptop Pro 15', 'Electronics', 'Laptops', 3500.00, 2700.00, 25),
(102, 'Wireless Mouse', 'Electronics', 'Accessories', 85.00, 45.00, 100),
(103, 'Mechanical Keyboard', 'Electronics', 'Accessories', 220.00, 130.00, 70),
(104, '27 Inch Monitor', 'Electronics', 'Monitors', 950.00, 650.00, 40),
(105, 'Wireless Headphones', 'Electronics', 'Audio', 450.00, 280.00, 60),
(106, 'Office Chair', 'Furniture', 'Chairs', 650.00, 420.00, 35),
(107, 'Office Desk', 'Furniture', 'Desks', 1100.00, 750.00, 20),
(108, 'Bookshelf', 'Furniture', 'Storage', 550.00, 350.00, 30),
(109, 'Standing Desk', 'Furniture', 'Desks', 1450.00, 980.00, 15),
(110, 'Desk Lamp', 'Furniture', 'Accessories', 180.00, 95.00, 80),
(111, 'Running Shoes', 'Fashion', 'Footwear', 320.00, 190.00, 55),
(112, 'Casual Shirt', 'Fashion', 'Clothing', 150.00, 80.00, 120),
(113, 'Denim Jeans', 'Fashion', 'Clothing', 250.00, 140.00, 90),
(114, 'Leather Jacket', 'Fashion', 'Clothing', 650.00, 390.00, 35),
(115, 'Sports Watch', 'Fashion', 'Accessories', 400.00, 250.00, 45),
(116, 'Coffee Maker', 'Home Appliances', 'Kitchen', 380.00, 230.00, 50),
(117, 'Air Fryer', 'Home Appliances', 'Kitchen', 520.00, 330.00, 45),
(118, 'Vacuum Cleaner', 'Home Appliances', 'Cleaning', 700.00, 450.00, 30),
(119, 'Blender', 'Home Appliances', 'Kitchen', 260.00, 150.00, 65),
(120, 'Electric Kettle', 'Home Appliances', 'Kitchen', 140.00, 75.00, 100);


-- =====================================================
-- 3. ORDERS DATA
-- =====================================================

INSERT INTO Orders
(OrderID, CustomerID, OrderDate, OrderStatus, PaymentMethod, ShippingCity, ShippingCountry)
VALUES
(1001, 1, '2025-06-21', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1002, 2, '2025-06-22', 'Delivered', 'PayPal', 'Dubai', 'UAE'),
(1003, 3, '2025-06-23', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1004, 4, '2025-06-24', 'Delivered', 'Cash on Delivery', 'Abu Dhabi', 'UAE'),
(1005, 5, '2025-06-25', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1006, 6, '2025-06-26', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1007, 7, '2025-06-27', 'Delivered', 'PayPal', 'Doha', 'Qatar'),
(1008, 8, '2025-06-28', 'Delivered', 'Debit Card', 'Abu Dhabi', 'UAE'),
(1009, 9, '2025-06-29', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1010, 10, '2025-06-30', 'Delivered', 'Cash on Delivery', 'Doha', 'Qatar'),

(1011, 11, '2025-07-01', 'Delivered', 'Credit Card', 'Riyadh', 'Saudi Arabia'),
(1012, 12, '2025-07-02', 'Delivered', 'PayPal', 'Jeddah', 'Saudi Arabia'),
(1013, 13, '2025-07-03', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1014, 14, '2025-07-04', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1015, 15, '2025-07-05', 'Delivered', 'Cash on Delivery', 'Abu Dhabi', 'UAE'),
(1016, 16, '2025-07-06', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1017, 17, '2025-07-07', 'Delivered', 'Credit Card', 'Riyadh', 'Saudi Arabia'),
(1018, 18, '2025-07-08', 'Delivered', 'PayPal', 'Dubai', 'UAE'),
(1019, 19, '2025-07-09', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1020, 20, '2025-07-10', 'Delivered', 'Debit Card', 'Jeddah', 'Saudi Arabia'),

(1021, 21, '2025-07-11', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1022, 22, '2025-07-12', 'Delivered', 'Cash on Delivery', 'Doha', 'Qatar'),
(1023, 23, '2025-07-13', 'Delivered', 'PayPal', 'Abu Dhabi', 'UAE'),
(1024, 24, '2025-07-14', 'Delivered', 'Credit Card', 'Riyadh', 'Saudi Arabia'),
(1025, 25, '2025-07-15', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1026, 26, '2025-07-16', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1027, 27, '2025-07-17', 'Delivered', 'PayPal', 'Jeddah', 'Saudi Arabia'),
(1028, 28, '2025-07-18', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1029, 29, '2025-07-19', 'Delivered', 'Debit Card', 'Dubai', 'UAE'),
(1030, 30, '2025-07-20', 'Delivered', 'Credit Card', 'Abu Dhabi', 'UAE'),

(1031, 1, '2025-07-21', 'Delivered', 'PayPal', 'Doha', 'Qatar'),
(1032, 2, '2025-07-22', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1033, 3, '2025-07-23', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1034, 4, '2025-07-24', 'Delivered', 'Credit Card', 'Abu Dhabi', 'UAE'),
(1035, 5, '2025-07-25', 'Delivered', 'Cash on Delivery', 'Doha', 'Qatar'),
(1036, 6, '2025-07-26', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1037, 7, '2025-07-27', 'Delivered', 'PayPal', 'Doha', 'Qatar'),
(1038, 8, '2025-07-28', 'Delivered', 'Debit Card', 'Abu Dhabi', 'UAE'),
(1039, 9, '2025-07-29', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1040, 10, '2025-07-30', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),

(1041, 11, '2025-08-01', 'Delivered', 'PayPal', 'Riyadh', 'Saudi Arabia'),
(1042, 12, '2025-08-02', 'Delivered', 'Credit Card', 'Jeddah', 'Saudi Arabia'),
(1043, 13, '2025-08-03', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1044, 14, '2025-08-04', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1045, 15, '2025-08-05', 'Delivered', 'Cash on Delivery', 'Abu Dhabi', 'UAE'),
(1046, 16, '2025-08-06', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1047, 17, '2025-08-07', 'Delivered', 'Credit Card', 'Riyadh', 'Saudi Arabia'),
(1048, 18, '2025-08-08', 'Delivered', 'PayPal', 'Dubai', 'UAE'),
(1049, 19, '2025-08-09', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1050, 20, '2025-08-10', 'Delivered', 'Debit Card', 'Jeddah', 'Saudi Arabia'),

(1051, 21, '2025-08-11', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1052, 22, '2025-08-12', 'Delivered', 'Cash on Delivery', 'Doha', 'Qatar'),
(1053, 23, '2025-08-13', 'Delivered', 'PayPal', 'Abu Dhabi', 'UAE'),
(1054, 24, '2025-08-14', 'Delivered', 'Credit Card', 'Riyadh', 'Saudi Arabia'),
(1055, 25, '2025-08-15', 'Delivered', 'Debit Card', 'Doha', 'Qatar'),
(1056, 26, '2025-08-16', 'Delivered', 'Credit Card', 'Dubai', 'UAE'),
(1057, 27, '2025-08-17', 'Delivered', 'PayPal', 'Jeddah', 'Saudi Arabia'),
(1058, 28, '2025-08-18', 'Delivered', 'Credit Card', 'Doha', 'Qatar'),
(1059, 29, '2025-08-19', 'Delivered', 'Debit Card', 'Dubai', 'UAE'),
(1060, 30, '2025-08-20', 'Delivered', 'Credit Card', 'Abu Dhabi', 'UAE');


-- =====================================================
-- 4. ORDER ITEMS DATA
-- =====================================================

INSERT INTO OrderItems
(OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1001, 101, 1, 3500.00),
(2, 1001, 102, 2, 85.00),

(3, 1002, 104, 1, 950.00),
(4, 1002, 103, 1, 220.00),

(5, 1003, 106, 2, 650.00),
(6, 1003, 110, 2, 180.00),

(7, 1004, 107, 1, 1100.00),
(8, 1004, 108, 1, 550.00),

(9, 1005, 105, 2, 450.00),
(10, 1005, 102, 1, 85.00),

(11, 1006, 109, 1, 1450.00),
(12, 1006, 110, 2, 180.00),

(13, 1007, 111, 2, 320.00),
(14, 1007, 113, 1, 250.00),

(15, 1008, 114, 1, 650.00),
(16, 1008, 115, 1, 400.00),

(17, 1009, 116, 2, 380.00),
(18, 1009, 119, 1, 260.00),

(19, 1010, 117, 1, 520.00),
(20, 1010, 120, 2, 140.00),

(21, 1011, 101, 1, 3500.00),
(22, 1011, 103, 2, 220.00),

(23, 1012, 104, 2, 950.00),
(24, 1012, 105, 1, 450.00),

(25, 1013, 106, 1, 650.00),
(26, 1013, 107, 1, 1100.00),

(27, 1014, 108, 2, 550.00),
(28, 1014, 110, 1, 180.00),

(29, 1015, 109, 1, 1450.00),
(30, 1015, 106, 1, 650.00),

(31, 1016, 111, 1, 320.00),
(32, 1016, 112, 2, 150.00),

(33, 1017, 113, 2, 250.00),
(34, 1017, 114, 1, 650.00),

(35, 1018, 115, 1, 400.00),
(36, 1018, 116, 2, 380.00),

(37, 1019, 117, 2, 520.00),
(38, 1019, 118, 1, 700.00),

(39, 1020, 119, 2, 260.00),
(40, 1020, 120, 2, 140.00),

(41, 1021, 101, 1, 3500.00),
(42, 1021, 104, 1, 950.00),

(43, 1022, 102, 3, 85.00),
(44, 1022, 103, 1, 220.00),

(45, 1023, 105, 2, 450.00),
(46, 1023, 106, 1, 650.00),

(47, 1024, 107, 1, 1100.00),
(48, 1024, 109, 1, 1450.00),

(49, 1025, 110, 3, 180.00),
(50, 1025, 108, 1, 550.00),

(51, 1026, 111, 2, 320.00),
(52, 1026, 112, 2, 150.00),

(53, 1027, 113, 1, 250.00),
(54, 1027, 115, 1, 400.00),

(55, 1028, 116, 1, 380.00),
(56, 1028, 117, 1, 520.00),

(57, 1029, 118, 1, 700.00),
(58, 1029, 119, 2, 260.00),

(59, 1030, 120, 3, 140.00),
(60, 1030, 102, 2, 85.00),

(61, 1031, 101, 1, 3500.00),
(62, 1032, 104, 1, 950.00),
(63, 1033, 106, 1, 650.00),
(64, 1034, 107, 1, 1100.00),
(65, 1035, 111, 2, 320.00),
(66, 1036, 114, 1, 650.00),
(67, 1037, 116, 2, 380.00),
(68, 1038, 117, 1, 520.00),
(69, 1039, 118, 1, 700.00),
(70, 1040, 103, 2, 220.00);


-- =====================================================
-- VERIFY DATA
-- =====================================================

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT COUNT(*) AS TotalProducts
FROM Products;

SELECT COUNT(*) AS TotalOrders
FROM Orders;

SELECT COUNT(*) AS TotalOrderItems
FROM OrderItems;