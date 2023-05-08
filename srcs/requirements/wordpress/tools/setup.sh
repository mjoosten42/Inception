#!/bin/bash

# TODO: remove WP_DEBUG

if ! wp core is-installed; then
	wp core download

	wp config create				\
		--dbhost=mariadb			\
		--dbname=$DB_NAME			\
		--dbuser=$MYSQL_USER		\
		--dbpass=$MYSQL_PASSWORD	\
		--extra-php <<-EOF
			define( 'WP_DEBUG', true );
			define( 'WP_DEBUG_LOG', true );
		EOF

	wp core install								\
		--title=Inception						\
		--url=$DOMAIN_NAME:443					\
		--admin_user=root						\
		--admin_password=$MYSQL_ROOT_PASSWORD	\
		--admin_email=noreply@42.fr				\
		--skip-email

	wp user create $MYSQL_USER --user_pass=$MYSQL_PASSWORD noreply+1@42.fr
fi

php-fpm7.3 --nodaemonize
