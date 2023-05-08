#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

EXPOSE 9000

# Install php fastcgi, to repond to nginx
# php-fpm needs the /run/php but doesn't create it itself
RUN <<EOF
	apt-get update
	apt-get install -y php-fpm php-mysql curl mariadb-client
	curl -o /usr/local/bin/wp \
		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x /usr/local/bin/wp
	install -d /run/php -o www-data -g www-data
EOF

# TODO
ARG X=15
RUN echo $X

# Add my configuration to the pool
COPY conf/ /etc/php/7.3/fpm/pool.d/
COPY tools/setup.sh /setup.sh

USER www-data

WORKDIR /var/www/html

HEALTHCHECK --interval=1s --retries=60 CMD [ "wp", "core", "is-installed" ]

# wp needs to connect to the mariadb container, which isn't available during the build stage
ENTRYPOINT [ "/setup.sh" ]
