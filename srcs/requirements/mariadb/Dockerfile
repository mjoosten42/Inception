#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

ARG MYSQL_USER
ARG MYSQL_PASSWORD

EXPOSE 3306

# install: create directories and set ownership to mysql
# usermod -d: set home directory
RUN <<EOF
	apt-get update
	apt-get install -y mariadb-server
	install -d /home/mysql /run/mysqld -o mysql -g mysql 
	usermod -d /home/mysql mysql
EOF

# mysqld reads ~/.my.cnf
COPY --chown=mysql conf/my.cnf /home/mysql/.my.cnf
COPY tools/setup.sh /setup.sh

USER mysql

# Wait for mysql to be reachable before starting wordpress
HEALTHCHECK --interval=1s  CMD mysql -u $MYSQL_USER -p$MYSQL_PASSWORD

ENTRYPOINT [ "./setup.sh" ]
