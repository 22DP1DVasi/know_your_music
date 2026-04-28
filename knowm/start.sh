#!/bin/bash
# Wait for MySQL to be reachable
echo "Waiting for MySQL..."
until php -r "new PDO('mysql:host=${DB_HOST};port=${DB_PORT};dbname=${DB_DATABASE}', '${DB_USERNAME}', '${DB_PASSWORD}');" 2>/dev/null; do
  sleep 2
done
echo "MySQL is up."

php artisan migrate --force --no-interaction --path=database/migrations/2026_04_28_054326_import_initial_data_from_sql_dump.php
php artisan config:cache
php artisan route:cache
php artisan view:cache
service apache2 start
php-fpm -F
