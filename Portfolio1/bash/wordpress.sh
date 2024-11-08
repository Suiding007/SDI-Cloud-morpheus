#! /bin/bash
#improved by chatgpt
# basic configuration
DB_NAME="WordPress"
DB_USER="wordpress"
DB_PASSWORD="Ubuntu"

echo "============================================" 
echo "update and upgrade" 
echo "============================================" 

apt update
apt upgrade -y

echo "============================================" 
echo "Installing apache2" 
echo "============================================" 
apt update
apt install apache2 -y
systemctl enable apache2

echo "============================================" 
echo "Installing mysql" 
echo "============================================" 
apt install mysql-server -y

echo "============================================" 
echo "Installing php" 
echo "============================================" 
apt install php libapache2-mod-php php-mysql php-curl php-gd php-imagick php-mbstring php-xml php-xmlrpc -y
systemctl restart apache2

echo "============================================" 
echo "Creating wordpress database and user" 
echo "============================================" 
mysql -e "CREATE DATABASE ${DB_NAME};"
mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

echo "============================================" 
echo "Downloading and installing wordpress" 
echo "============================================" 
cd /var/www/html
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress/* .
rm -rf wordpress latest.tar.gz
cp wp-config-sample.php wp-config.php

echo "============================================" 
echo "Configuring WordPress" 
echo "============================================" 
sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/username_here/${DB_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" /var/www/html/wp-config.php

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

a2enmod rewrite

sed -i 's/DirectoryIndex.*$/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf

systemctl restart apache2

echo "============================================" 
echo "Wordpress succesfully installed"
echo "go to the url: http://<ip>/wp-admin/" 
echo "============================================" 