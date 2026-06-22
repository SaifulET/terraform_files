#!/bin/bash

set -e

APP_DIR="/home/ubuntu/module-6-project"

echo "Starting deployment..."

cd "$APP_DIR"

echo "Pulling latest code..."
git pull origin main

echo "Deploying backend..."

cd backend

npm ci

if [ -f package.json ] && npm run | grep -q migrate; then
  npm run migrate
fi

if pm2 describe bmi-backend > /dev/null 2>&1; then
  pm2 restart bmi-backend
else
  pm2 start src/server.js --name bmi-backend
fi

pm2 save

echo "Deploying frontend..."

cd ../frontend

npm ci

npm run build

sudo rm -rf /var/www/html/*

sudo cp -r build/* /var/www/html/

echo "Restarting Nginx..."

sudo systemctl restart nginx

echo "Deployment completed successfully."
