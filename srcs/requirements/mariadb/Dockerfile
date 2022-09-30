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

# True Inception
# Add password to root and add a normal user
RUN <<EOF
	apt-get update
	apt-get install -y mariadb-server
	service mysql start
	mariadb << EOF
		SET PASSWORD FOR "root"@"localhost" = PASSWORD("$MYSQL_ROOT_PASSWORD");
		CREATE DATABASE IF NOT EXISTS $DB_NAME;
		CREATE OR REPLACE USER "$MYSQL_USER"@"%" IDENTIFIED BY "$MYSQL_PASSWORD"; 
		GRANT ALL ON $DB_NAME.* TO "$MYSQL_USER"@"%";
		FLUSH PRIVILEGES;
		EXIT
	EOF
EOF

# Mysql daemon
ENTRYPOINT mysqld
