#!/bin/bash
set -x
apt update -y && apt install curl -y

if ! command -v apache2 &> /dev/null; then
    echo "Apache2 is not installed. Installing..."
    apt install -y apache2
else
    echo "Apache2 is already installed. Skipping installation."
fi

rm -f /var/www/html/index.html && cp ./index.html /var/www/html/ && chown www-data:www-data /var/www/html/*
service apache2 start && service apache2 restart
container_ip=$(hostname -I | awk '{print $1}')
curl http://$container_ip:80 >> check.txt

