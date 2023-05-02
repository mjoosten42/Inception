#!/bin/bash

# sql files don't read env

cat << EOF > ~/init.sql
	ALTER USER "root"@"localhost" IDENTIFIED BY "$MYSQL_ROOT_PASSWORD";
	CREATE DATABASE IF NOT EXISTS $DB_NAME;
	CREATE USER IF NOT EXISTS "$MYSQL_USER"@"wordpress" IDENTIFIED BY "$MYSQL_PASSWORD";
	GRANT ALL ON $DB_NAME.* TO "$MYSQL_USER"@"wordpress";
	FLUSH PRIVILEGES;
EOF

mysqld --init-file ~/init.sql
