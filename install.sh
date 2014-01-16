#!/bin/bash
# version 1.5 - 2014.03.2

echo Starting installation procedure..

echo -e "\e[1m--- Install Apache2 ---\e[0m"
sudo apt-get install apache2
sudo a2enmod rewrite
sudo service apache2 restart

echo -e "\e[1m--- Install PHP5 ---\e[0m"
sudo apt-get install libapache2-mod-php5
sudo service apache2 restart

echo -e "\e[1m--- Install PHP5 MySQL Drivers ---\e[0m"
sudo apt-get install php5-mysql

echo -e "\e[1m--- Prepare /var/www ---\e[0m"
sudo adduser $USER www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rw /var/www

echo -e "\e[1m--- Update to PHP5.4 ---\e[0m"
sudo add-apt-repository -y ppa:ondrej/php5-oldstable
sudo apt-get update
sudo apt-get install php5
sudo service apache2 restart

echo -e "\e[1m--- Install MySQL ---\e[0m"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password devroot'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password devroot'
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql

echo -e "\e[1m--- Install cURL ---\e[0m"
sudo apt-get install php5-curl
sudo service apache2 restart

echo -e "\e[1m--- Configure Apache ---\e[0m"
echo - Prepare log files -
sudo chmod 777 -R /etc/apache2/logs

echo - Enable Virtual Hosts -
sudo a2dissite default
sudo cp vhost/dev.com /etc/apache2/sites-available/dev.com
sudo cp vhost/dev.com /etc/apache2/sites-available/dev.com.conf
sudo cp vhost/www.dev.com /etc/apache2/sites-available/www.dev.com
sudo cp vhost/www.dev.com /etc/apache2/sites-available/www.dev.com.conf

sudo a2ensite dev.com
sudo a2ensite www.dev.com
sudo service apache2 restart

echo - Fix Permissions -
cd ..
sudo chmod 777 -R www
cd www

echo -e "\e[1m--- Install Symfony on dev.com ---\e[0m"
mkdir dev.com
cd dev.com
echo - Downloading Composer -
curl -sS https://getcomposer.org/installer | php
php composer.phar config --global discard-changes true
echo - Installing Symfony -
php composer.phar create-project symfony/framework-standard-edition . 2.4.*

cd ..

echo Done.
