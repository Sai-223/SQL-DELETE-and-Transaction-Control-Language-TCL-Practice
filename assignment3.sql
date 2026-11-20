SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE ShopDB;
USE ShopDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES (1, 'Asha Reddy', 'asha@gmail.com');
INSERT INTO Customers VALUES (2, 'Ravi Kumar', 'ravi@example.com');
INSERT INTO Customers VALUES (3, 'Meera Iyer', 'meera@yahoo.com');
INSERT INTO Customers VALUES (4, 'John Smith', 'john@example.com');
INSERT INTO Customers VALUES (5, 'Priya Nair', 'priya@gmail.com');
INSERT INTO Customers VALUES (6, 'Karan Shah', 'karan@outlook.com');

INSERT INTO Products VALUES (1, 'Laptop', 55000);
INSERT INTO Products VALUES (2, 'Mouse', 500);
INSERT INTO Products VALUES (3, 'Keyboard', 1500);
INSERT INTO Products VALUES (4, 'Monitor', 12000);
INSERT INTO Products VALUES (5, 'USB Cable', 200);
INSERT INTO Products VALUES (6, 'Webcam', 3000);

INSERT INTO Orders VALUES (1, 1, 1, 1, '2022-03-10');
INSERT INTO Orders VALUES (2, 2, 2, 2, '2023-01-15');
INSERT INTO Orders VALUES (3, 3, 3, 1, '2026-05-20');
INSERT INTO Orders VALUES (4, 4, 4, 1, '2026-08-12');
INSERT INTO Orders VALUES (5, 5, 2, 0, '2026-09-01');
INSERT INTO Orders VALUES (6, 6, 5, 3, '2026-10-05');
INSERT INTO Orders VALUES (7, 1, 3, 2, '2025-12-01');
INSERT INTO Orders VALUES (8, 3, 4, 1, '2026-11-02');

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

DELETE FROM Orders
WHERE order_date < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

SELECT * FROM Orders;

DELETE FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Orders);

SELECT * FROM Products;

DELETE FROM Customers
WHERE customer_id = 6;

SELECT * FROM Customers;
SELECT * FROM Orders;

START TRANSACTION;
DELETE FROM Orders WHERE product_id = 4;
DELETE FROM Products WHERE product_id = 4;
DELETE FROM Orders WHERE wrong_column = 1;
ROLLBACK;

SELECT * FROM Products;
SELECT * FROM Orders;

START TRANSACTION;
DELETE FROM Orders WHERE order_date < '2026-01-01';
COMMIT;

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

DELETE FROM Customers
WHERE email LIKE '%@example.com';

SELECT * FROM Customers;
SELECT * FROM Orders;

DELETE FROM Orders
WHERE quantity = 0;

SELECT * FROM Orders;

START TRANSACTION;
SAVEPOINT before_delete;
DELETE FROM Orders WHERE order_id = 8;
SELECT * FROM Orders;
ROLLBACK TO SAVEPOINT before_delete;
SELECT * FROM Orders;
COMMIT;