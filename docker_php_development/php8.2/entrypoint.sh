#!/bin/bash

echo "Setting permissions for Laravel projects..."

# Loop through each Laravel project inside /var/www/php/php8.2/

for project in /var/www/php/php8.2/*; do
    if [ -d "$project/storage" ] && [ -d "$project/bootstrap/cache" ]; then
        echo "Fixing permissions for: $project"
        chown -R laravel:laravel "$project"
        chmod -R 775 "$project/storage" "$project/bootstrap/cache"
    fi
done

echo "Permissions set successfully!"

# Start PHP-FPM

exec php-fpm
