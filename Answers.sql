--this queary creates bookstore data base--
CREATE DATABASE  bookstoredb;
--this initiates the use of bookstoredb--

USE bookstoredb;


CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_date DATE,
    publisher_id INT,
    language_id INT
);

CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255) NOT NULL
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20),
    country_id INT,
    address_status_id INT
);

CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);


CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2)
);
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_date DATETIME,
    order_status_id INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


