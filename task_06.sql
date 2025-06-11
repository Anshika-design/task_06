create database ecommerce;
use ecommerce;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    city VARCHAR(100),
    registration_date DATE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers (name, email, city, registration_date) VALUES
('Anshika Sharma', 'anshika@example.com', 'Delhi', '2024-01-10'),
('Rahul Mehta', 'rahul@example.com', 'Mumbai', '2024-02-15'),
('Priya Kapoor', 'priya@example.com', 'Bangalore', '2024-03-20');

INSERT INTO products (name, category, price, stock_quantity) VALUES
('Wireless Mouse', 'Electronics', 899.00, 50),
('Laptop Stand', 'Accessories', 1299.00, 30),
('Bluetooth Speaker', 'Audio', 3499.00, 20);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-03-10', 1299.00),
(2, '2024-04-05', 899.00),
(3, '2024-04-20', 3499.00);

INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES
(1, 2, 1, 1299.00),
(2, 1, 1, 899.00),
(3, 3, 1, 3499.00);

SELECT p.name, SUM(oi.quantity) AS total_sold 
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

SELECT city, COUNT(order_id) AS total_orders 
FROM orders 
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY city
ORDER BY total_orders DESC;