#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

FROM debian:buster

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

ENTRYPOINT [ "./setup.sh" ]
