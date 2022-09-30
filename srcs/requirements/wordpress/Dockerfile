#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

# Install php fastcgi, to repond to nginx
# Also install php-mysql to allow php to connect to the mysql database
RUN <<EOF
	apt-get update
	apt-get install -y php-fpm php-mysql
	mkdir /run/php
EOF

# Add our configuration to the pool
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN <<EOF
	apt-get install -y wget tar
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -f latest.tar.gz
EOF

# Manually start php-fpm
# It usually starts automatically but we're missing an init process
# This is also why we need to create /run/php
# -F: --nodaemonize AKA run in foreground
ENTRYPOINT php-fpm7.3 -F
