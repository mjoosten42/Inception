#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

# Stupid docker-compose doesn't pass env to build stage
# ARGs are set by the docker-compose.yml
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG DB_NAME

# Allow remote access
# Mysqld searches ~/.my.cnf
COPY conf/my.cnf /root/.my.cnf

# Script to setup mariadb
COPY tools/setup.sh /setup.sh

# TODO: run initialization in dockerfile using heredoc(?)
# Install mariadb
# Add password to root and add a normal user
RUN <<EOF
	apt-get update
	apt-get install -y mariadb-server
	service mysql start
	./setup.sh
EOF

# RUN <<EOF
# 	service mysql start
# 	mariadb -p${MYSQL_ROOT_PASSWORD} << EOF
# 		CREATE OR REPLACE USER 'test'@'%';
# 		EXIT
# 	EOF
# EOF

# Mysql daemon
ENTRYPOINT mysqld
