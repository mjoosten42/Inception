#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

# Install php fastcgi, to repond to nginx
# Also install php-mysql to allow php to connect to the mysql database
# php-fpm needs the /run/php but doesn't create it itself
RUN <<EOF
	apt-get update
	apt-get install -y php-fpm php-mysql
	mkdir /run/php
EOF

# Add our configuration to the pool
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# Installing wp-cli and making it executable
# /var/www doesn't exist yet because the volume hasn't been created
RUN <<EOF
	apt-get install -y wget mariadb-client
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
	chmod +x /usr/local/bin/wp
	mkdir -p /var/www/wordpress
	wp --allow-root --path=/var/www/wordpress core download
EOF

COPY tools/setup.sh /setup.sh

# Wp needs to connect to the mariadb container, which isn't available during the build stage
# -F: --nodaemonize AKA run in foreground
ENTRYPOINT ./setup.sh && php-fpm7.3 -F
