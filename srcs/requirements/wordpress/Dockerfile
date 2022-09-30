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

# I'm installing wordpress via wp-cli, because the mandatory site setup is difficult to do from the command line
RUN <<EOF
	apt-get install -y wget
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/sbin/wp
EOF

# -F: --nodaemonize AKA run in foreground
ENTRYPOINT php-fpm7.3 -F
