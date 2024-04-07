#!/bin/bash
set -x
sudo apt update -y && sudo apt install curl -y

if ! command -v apache2 &> /dev/null; then
    sudo echo "Apache2 is not installed. Installing..."
    sudo apt install -y apache2
else
    echo "Apache2 is already installed. Skipping installation."
fi

sudo rm -f /var/www/html/index.html && sudo cp ./index.html /var/www/html/ && sudo chown www-data:www-data /var/www/html/*
sudo service apache2 start && sudo service apache2 restart
container_ip=$(hostname -I | awk '{print $1}')
sudo curl http://$container_ip:80 >> check.txt

