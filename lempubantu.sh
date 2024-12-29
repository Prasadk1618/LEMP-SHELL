#!/bin/bash

# Update package lists
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Install MySQL Server
sudo apt install -y mysql-server

# Run the MySQL Secure Installation wizard
sudo mysql_secure_installation

# Start and enable MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Install PHP and necessary extensions
sudo apt install -y php-fpm php-mysql

# Configure PHP Processor
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;")/fpm/php.ini

# Restart PHP processor
sudo systemctl restart php$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;")-fpm

# Create a basic PHP info page to test
sudo echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# Set ownership of the web directory
sudo chown -R www-data:www-data /var/www/html

# Open firewall for Nginx
sudo ufw allow 'Nginx Full'

echo "LEMP stack installed successfully!"
