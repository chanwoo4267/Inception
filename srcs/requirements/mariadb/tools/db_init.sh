#!/bin/bash

echo "MariaDB: using .env sed_ing..."
sed -i "s/DB_NAME_HERE/$DB_NAME/g" "/var/www/initial_db.sql"
sed -i "s/USER_NAME_HERE/$DB_USER_NAME/g" "/var/www/initial_db.sql"
sed -i "s/USER_PASSWORD_HERE/$DB_USER_PASSWORD/g" "/var/www/initial_db.sql"
sed -i "s/ROOT_PASSWORD_HERE/$DB_ROOT_PASSWORD/g" "/var/www/initial_db.sql"

echo "MariaDB: query mysql..."
service mysql start 
mysql < /var/www/initial_db.sql
kill $(cat /var/run/mysqld/mysqld.pid)

echo "MariaDB: delete copied files..."
rm -rf /var/www/initial_db.sql

echo "MariaDB: change authority for mysql..."
chmod -R 755 /var/lib/mysql/
chown -R mysql:mysql /var/lib/mysql/

echo "MariaDB: execute mysqld..."
mysqld

exec "$@"