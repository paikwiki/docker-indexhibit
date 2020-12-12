#!/bin/bash

ROOT_DIR="/var/www/localhost"

service mysql start

echo "UPDATE mysql.user SET plugin = 'mysql_native_password'
		WHERE user='root';" | mysql -u root --skip-password
echo "CREATE DATABASE indexhibit;" \
		| mysql -u root --skip-password
echo "CREATE USER 'indexhibit'@'localhost' IDENTIFIED BY 'password'" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON indexhibit.* TO 'indexhibit'@'localhost'" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES" \
		| mysql -u root --skip-password

tar -xf indexhibit.tar
mv -f /indexhibit-master ${ROOT_DIR}
chmod 777 ${ROOT_DIR}/files/ ${ROOT_DIR}/files/gimgs/ ${ROOT_DIR}/files/dimgs/ \
		${ROOT_DIR}/ndxzsite/config/ ${ROOT_DIR}/ndxzsite/cache/
service php7.2-fpm start
service apache2 start
chown -R www-data /var/www/*
chmod -R 755 /var/www/*
echo "Visit the installation page: http://localhost/ndxzstudio/install.php"
bash
