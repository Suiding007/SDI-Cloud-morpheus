#! /bin/bash

echo "============================================" 
echo "install mysql" 
echo "============================================" 
sudo apt install mysql-server -y
echo

echo "============================================" 
echo "install zabbix" 
echo "============================================" 

wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-2+ubuntu22.04_all.deb
apt update
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

mysql -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -e "create user zabbix@localhost identified by 'password';"
mysql -e "grant all privileges on zabbix.* to zabbix@localhost;"
mysql -e "set global log_bin_trust_function_creators = 1;"

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix 
mysql -e "set global log_bin_trust_function_creators = 0;"

sed -i "s/# DBPassword=/DBPassword=password/" /etc/zabbix/zabbix_server.conf

#nano /etc/locale.gen
#dpkg-reconfigure locales

systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

echo "============================================" 
echo "installing zabbix finished" 
echo "go to the url: http://<ip>/zabbix/"
echo "============================================" 