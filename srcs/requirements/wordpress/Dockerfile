#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

ADD --chmod=755 \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	/usr/local/bin/wp

EXPOSE 9000

# Install php fastcgi, to repond to nginx
# php-fpm needs the /run/php but doesn't create it itself
# /var/www/html volume is set to root if not created in a container
RUN <<EOF
	apt-get update
	apt-get install -y php-fpm php-mysql curl mariadb-client
	install -d /run/php /var/www/html -o www-data -g www-data
EOF

# Overwrite default www.conf
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY tools/setup.sh /setup.sh

USER www-data

WORKDIR /var/www/html

HEALTHCHECK --interval=1s --retries=30 CMD [ "wp", "core", "is-installed" ]

# wp needs to connect to the mariadb container, which isn't available during the build stage
ENTRYPOINT [ "/setup.sh" ]
