#!/bin/sh
set -e

# composer install again to tidy up optimisation
# composer install

# Clear configurations to avoid caching issues in development
echo "Clearing configurations..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

# migrate
php artisan migrate

# Run the default command (e.g., php-fpm or bash)
exec "$@"&
