CREATE DATABASE IF NOT EXISTS DB_NAME_HERE;
CREATE USER IF NOT EXISTS 'USER_NAME_HERE'@'%' IDENTIFIED BY 'USER_PASSWORD_HERE';
GRANT ALL PRIVILEGES ON DB_NAME_HERE.* TO 'USER_NAME_HERE'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'ROOT_PASSWORD_HERE';