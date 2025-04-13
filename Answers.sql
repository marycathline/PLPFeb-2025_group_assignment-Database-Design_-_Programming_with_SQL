CREATE DATABASE data_trio_bookstore_db;            

-- Use the database created above
USE data_trio_bookstore_db;

-- 1. book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- 2. publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100)
);

-- 3. author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- 4. book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year YEAR,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- 5. book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- 7. address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- 8. address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 9. customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- 10. customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 11. shipping_method
CREATE TABLE shipping_method (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

-- 12. order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- 13. cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 14. order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price_each DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    updated_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Languages
INSERT INTO book_language (language_name)
VALUES 
  ('English'), 
  ('Swahili'), 
  ('French'),
  ('Arabic'),
  ('Portuguese');

-- Publishers
INSERT INTO publisher (name, country)
VALUES 
  ('EA Books Ltd', 'Kenya'), 
  ('PanAfrica Publishers', 'Uganda'),
  ('Safari Press', 'Tanzania'),
  ('Lakeview Media', 'Kenya'),
  ('Rwenzori House', 'Uganda');

-- Authors
INSERT INTO author (first_name, last_name)
VALUES 
  ('Ngugi', 'wa Thiong\'o'), 
  ('Chimamanda', 'Adichie'), 
  ('Yvonne', 'Owuor'), 
  ('Ben', 'Okri'), 
  ('Meja', 'Mwangi');

-- Countries
INSERT INTO country (country_name)
VALUES 
  ('Kenya'), 
  ('Uganda'), 
  ('Tanzania'),
  ('Rwanda'),
  ('South Sudan');

-- Address Status
INSERT INTO address_status (status_name)
VALUES 
  ('current'), 
  ('old'),
  ('temporary'),
  ('inactive'),
  ('secondary');

-- Shipping Methods
INSERT INTO shipping_method (method_name)
VALUES 
  ('Pickup - Nairobi'), 
  ('Courier - East Africa'), 
  ('Global Shipping'),
  ('Boda Delivery - Local'),
  ('Postal Mail');

-- Order Statuses
INSERT INTO order_status (status_name)
VALUES 
  ('pending'), 
  ('shipped'), 
  ('delivered'), 
  ('cancelled'),
  ('on hold');

-- Addresses
INSERT INTO address (street, city, postal_code, country_id)
VALUES 
  ('Kenyatta Ave', 'Nairobi', '00100', 1),
  ('Moi Ave', 'Mombasa', '80100', 1),
  ('Jinja Rd', 'Kampala', '25600', 2),
  ('Uhuru St', 'Arusha', '23100', 3),
  ('Remera Blvd', 'Kigali', '00250', 4);

-- Customers
INSERT INTO customer (first_name, last_name, email)
VALUES 
  ('Achieng', 'Otieno', 'achieng@example.com'),
  ('John', 'Kamau', 'johnk@example.com'),
  ('Fatuma', 'Ali', 'fatuma@example.com'),
  ('Brian', 'Wanyama', 'brianw@example.com'),
  ('Grace', 'Mutiso', 'gracem@example.com');

-- Customer Addresses
INSERT INTO customer_address (customer_id, address_id, status_id)
VALUES 
  (1, 1, 1), 
  (2, 2, 1),
  (3, 3, 1),
  (4, 4, 2),
  (5, 5, 3);

-- Books
INSERT INTO book (title, isbn, publication_year, language_id, publisher_id, price)
VALUES 
  ('The River Between', '9780141187034', 2004, 1, 1, 750.00),
  ('Half of a Yellow Sun', '9780007200283', 2006, 1, 2, 1200.00),
  ('Dust', '9780345804122', 2013, 1, 3, 950.00),
  ('The Famished Road', '9780385425131', 1991, 1, 4, 1100.00),
  ('Going Down River Road', '9789966467514', 1976, 2, 5, 670.00);

-- Book Authors
INSERT INTO book_author (book_id, author_id)
VALUES 
  (1, 1), 
  (2, 2), 
  (3, 3),
  (4, 4),
  (5, 5);

-- Orders
INSERT INTO cust_order (customer_id, order_date, shipping_id, status_id)
VALUES 
  (1, '2025-04-01', 2, 1),
  (2, '2025-04-10', 1, 2),
  (3, '2025-04-05', 3, 3),
  (4, '2025-04-08', 4, 4),
  (5, '2025-04-09', 5, 1);

-- Order Lines
INSERT INTO order_line (order_id, book_id, quantity, price_each)
VALUES 
  (1, 1, 2, 750.00),
  (2, 2, 1, 1200.00),
  (3, 3, 1, 950.00),
  (4, 4, 1, 1100.00),
  (5, 5, 3, 670.00);

-- Order History
INSERT INTO order_history (order_id, status_id, updated_at)
VALUES 
  (1, 1, NOW()),
  (2, 2, NOW()),
  (3, 3, NOW()),
  (4, 4, NOW()),
  (5, 1, NOW());


-- Create a read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON data_trio_bookstore_db.* TO 'readonly_user'@'localhost';

-- Create an admin user with full privileges
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON data_trio_bookstore_db.* TO 'bookstore_admin'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

--END OF SQL DOC