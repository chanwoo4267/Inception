#!/bin/bash

	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chown -R www-data:www-data /var/www/*;
	chown -R 755 /var/www/*;
	mkdir -p /run/php/;
	touch /run/php/php7.3-fpm.pid;

	sed -i "s/DB_NAME_HERE/$DB_NAME/g" "/var/www/wp-config.php"
	sed -i "s/DB_USER_HERE/$DB_USER_NAME/g" "/var/www/wp-config.php"
	sed -i "s/DB_PASSWORD_HERE/$DB_USER_PASSWORD/g" "/var/www/wp-config.php"
	sed -i "s/DB_HOSTNAME_HERE/$WP_HOST/g" "/var/www/wp-config.php"

	sed -i "s/AUTH_KEY_HERE/$WP_AUTH_KEY/g" "/var/www/wp-config.php"
	sed -i "s/SECURE_KEY_HERE/$WP_SECURE_AUTH_KEY/g" "/var/www/wp-config.php"
	sed -i "s/LOGGED_IN_KEY_HERE/$WP_LOGGED_IN_KEY/g" "/var/www/wp-config.php"
	sed -i "s/NONCE_KEY_HERE/$WP_NONCE_KEY/g" "/var/www/wp-config.php"
	sed -i "s/AUTH_SALT_HERE/$WP_AUTH_SALT/g" "/var/www/wp-config.php"
	sed -i "s/SECURE_SALT_HERE/$WP_SECURE_AUTH_SALT/g" "/var/www/wp-config.php"
	sed -i "s/LOGGED_IN_SALT_HERE/$WP_LOGGED_IN_SALT/g" "/var/www/wp-config.php"
	sed -i "s/NONCE_SALT_HERE/$WP_NONCE_SALT/g" "/var/www/wp-config.php"

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: setting up..."
	mkdir -p /var/www/html
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;
	wp core download --allow-root;
	mv /var/www/wp-config.php /var/www/html/
	echo "Wordpress: creating users..."
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	echo "Wordpress: set up!"
fi

exec "$@"