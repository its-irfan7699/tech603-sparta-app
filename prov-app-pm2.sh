#!/bin/bash

echo "update..."
sudo apt update
echo done!
echo


echo "upgrade..."
sudo apt upgrade -y
echo done!
echo

echo "install nginx"
# nginx will be used later as a reverse proxy to forward requests to the application running on port 3000
# nginx when installed will be started automatically

sudo apt install nginx -y
echo done!
echo

# configure our reverse proxy
echo "configure nginx reverse proxy..."
sudo sed -i 's/try_files $uri $uri\/ =404;/proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-available/default
echo done!
echo

echo "restart nginx..."
sudo systemctl restart nginx


echo "restart nginx..."
sudo systemctl restart nginx
echo done!
echo

echo "run setup script for nodejs..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
echo done!
echo

echo "install nodejs..."
sudo apt-get install -y nodejs
echo done!
echo

# get app code
echo "clone the app code from github..."
git clone https://github.com/its-irfan7699/tech603-sparta-app.git
cd tech603-sparta-app/app
echo done!
echo

# run the app
echo "run the app..."
npm install pm2
npm install 
npx pm2 stop all
npx pm2 start index.js --name sparta-app

echo done!
echo