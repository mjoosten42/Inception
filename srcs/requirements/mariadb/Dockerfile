#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

# Stupid docker-compose doesn't pass env to build stage
ARG MYSQL_ROOT_PASSWORD=	$MYSQL_ROOT_PASSWORD
ARG MYSQL_USER=				$MYSQL_USER
ARG MYSQL_PASSWORD=			$MYSQL_PASSWORD

FROM debian:buster

# Script to setup mariadb
COPY tools/setup.sh /setup.sh

# Allow remote access
# COPY conf/my.cnf /etc/mysql/.my.cnf

# Install mariadb
# Apt-get will initialize mariadb, meaning I don't need to run mysql_install_db or similar
# Add password to root and add a normal user
RUN <<EOF
	apt-get update
	apt-get install -y mariadb-server
	mysql_install_db
EOF

RUN <<EOF
	service mysql start
	./setup.sh
EOF

ENTRYPOINT service mysql start && sleep 3000
