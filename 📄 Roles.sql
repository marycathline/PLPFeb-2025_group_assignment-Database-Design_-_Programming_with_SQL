-- Create users
CREATE USER 'Bookstore_admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER 'salesperson_user'@'localhost' IDENTIFIED BY 'Pass456!';
CREATE USER 'Frontdesk_user'@'localhost' IDENTIFIED BY 'pass789!';

-- Grant roles
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'Bookstore_admin_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BookstoreDB.* TO 'salesperson_user'@'localhost';
GRANT SELECT ON BookstoreDB.* TO 'Frontdesk_user'@'localhost';






