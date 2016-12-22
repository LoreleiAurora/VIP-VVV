#!/usr/bin/env bash

# Make a database, if we don't already have one
echo -e "\nCreating database 'vip' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS vip"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON vip.* TO wp@localhost IDENTIFIED BY 'wp';"
echo -e "\n DB operations done.\n\n"

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Install and configure the latest stable version of WordPress
if [[ ! -d "${VVV_PATH_TO_SITE}/wordpress" ]]; then
  wp core download --path="${VVV_PATH_TO_SITE}/wordpress" --allow-root
fi

cd ${VVV_PATH_TO_SITE}/wordpress

if [[ ! -f "${VVV_PATH_TO_SITE}/wordpress/wp-config.php" ]]; then
  echo "Configuring VIP..."
  noroot wp core config --dbname=vip --dbuser=wp --dbpass=wp --quiet --allow-root --extra-php <<PHP
define( 'WP_CONTENT_DIR', dirname( __DIR__ ) . '/wp-content' );

if ( ! isset( \$_SERVER['HTTP_HOST'] ) ) {
	\$_SERVER['HTTP_HOST'] = 'vip.localhost';
}

define( 'WP_DEBUG', true );
PHP
fi

if ! $(noroot wp core is-installed --allow-root); then
  echo "Installing VIP..."
  noroot wp core install --url=vip.localhost --quiet --title="VIP" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
  noroot wp theme install twenty-seventeen --activate
else
  echo "Updating VIP..."
  noroot wp core update
  noroot wp theme update twenty-seventeen
fi
