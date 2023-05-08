#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

ARG DB_NAME
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

EXPOSE 3306

# install: create directories and set ownership to mysql (mkdir + chown)
# usermod -d: set home directory
RUN <<EOF
	apt-get update
	apt-get install -y mariadb-server
	install -d /home/mysql /run/mysqld -o mysql -g mysql 
	usermod -d /home/mysql mysql
EOF

# mysqld reads ~/.my.cnf
COPY --chown=mysql conf/my.cnf /home/mysql/.my.cnf

USER mysql

WORKDIR /home/mysql

# mysqld doesn't read env
COPY --chown=mysql:mysql <<-EOF init.sql
	ALTER USER "root"@"localhost" IDENTIFIED BY "$MYSQL_ROOT_PASSWORD";
	CREATE DATABASE IF NOT EXISTS $DB_NAME;
	CREATE USER IF NOT EXISTS "$MYSQL_USER"@"%" IDENTIFIED BY "$MYSQL_PASSWORD";
	GRANT ALL ON $DB_NAME.* TO "$MYSQL_USER"@"%";
	FLUSH PRIVILEGES;
EOF

# Wait for mysql to be reachable before starting wordpress
# Can't do JSON syntax because variables need to be expanded
HEALTHCHECK --interval=1s CMD mysql -u $MYSQL_USER -p$MYSQL_PASSWORD

ENTRYPOINT [ "mysqld", "--init-file", "/home/mysql/init.sql" ]
