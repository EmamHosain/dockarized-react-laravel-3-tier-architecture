#!/bin/sh
set -e

cd /var/www/html/laravel

echo "Bootstrapping Laravel..."

# -----------------------------------
# 1. Install Laravel if missing
# -----------------------------------
if [ ! -f artisan ]; then
    echo "Laravel not found. Installing..."

    rm -rf temp

    composer create-project laravel/laravel temp

    echo "Moving Laravel files..."

    mv temp/* .
    mv temp/.[!.]* . 2>/dev/null || true

    rm -rf temp
fi

# -----------------------------------
# 2. Ensure correct .env (IMPORTANT)
# -----------------------------------
echo "Applying Docker environment configuration..."

if [ -f .env ]; then
    echo "Remove .env"
    rm .env
fi

if [ ! -f .env ]; then
    echo "Creating .env from .env.docker..."
    cp /usr/local/etc/.env.docker .env
fi


# -----------------------------------
# 3. Install dependencies
# -----------------------------------
if [ ! -d vendor ]; then
    echo "Installing dependencies..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

if [ ! -d node_modules ]; then
    echo "install node js"
    npm install
fi

# -----------------------------------
# 4. Fix permissions
# -----------------------------------
echo "Fixing permissions..."
chown -R www-data:www-data storage bootstrap/cache || true
chmod -R 775 storage bootstrap/cache || true

# -----------------------------------
# 5. Generate app key
# -----------------------------------
if ! grep -q "^APP_KEY=base64" .env; then
    echo "Generating app key..."
    php artisan key:generate --force
fi

# -----------------------------------
# 6. Wait for MySQL
# -----------------------------------
echo "Waiting for MySQL..."

until php -r "
try {
    new PDO('mysql:host=mysql;dbname=laravel_db', 'user', 'user123');
    echo 'DB connected\n';
} catch (Exception \$e) {
    exit(1);
}
"; do
    sleep 2
done

# -----------------------------------
# 7. Run migrations (background)
# -----------------------------------
(
    echo "Running migrations..."
    php artisan migrate --force || true

    echo "Clearing config cache..."
    php artisan config:clear || true
) &

# -----------------------------------
# 9. Start PHP-FPM
# -----------------------------------
echo "Starting PHP-FPM..."
exec php-fpm -F