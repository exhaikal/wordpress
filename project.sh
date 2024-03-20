#!/bin/bash
rm -rf /etc/apt/sources.list
echo -e "deb http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list
apt update
apt install mariadb-server mariadb-client -y
apt install apache2 -y
apt install php php-mysql -y
apt install unzip -y
mysql -e "create database wordpress;"
mysql -e "create user 'ukk'@'localhost' identified by 'ukk';"
mysql -e "grant all privileges on wordpress.* to 'ukk'@'localhost';"
mysql -e "flush privileges;"
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress/* /var/www/html/
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
sed -i "s/username_here/ukk/" /var/www/html/wp-config.php
sed -i "s/password_here/ukk/" /var/www/html/wp-config.php
rm -rf /var/www/html/index.html
systemctl restart apache2
echo "don bang THISISCEPOT"
