#!/bin/sh

# This might error if mariadb hasn't started yet, but the wordpress container will just restart and retry

wp --allow-root --path=/var/www/wordpress config create \
	--dbname=$DB_NAME			\
	--dbuser=$MYSQL_USER		\
	--dbpass=$MYSQL_PASSWORD	\
	--dbhost=mariadb
wp --allow-root --path=/var/www/wordpress core install	\
	--admin_user=root						\
	--admin_password=$MYSQL_ROOT_PASSWORD	\
	--url=mjoosten.42.fr					\
	--title=Inception						\
	--admin_email=noreply@42.fr				\
	--skip-email
