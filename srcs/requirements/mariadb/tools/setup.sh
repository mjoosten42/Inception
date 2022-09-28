# SQL files can't read env, so we'll use a heredoc

# GRANT creates a user if it doesn't exist

# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

mariadb << EOF
	CREATE DATABASE IF NOT EXISTS wordpress;
	CREATE OR REPLACE USER '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';
	GRANT ALL ON mysql.user TO '$MYSQL_USER'@'%';
	FLUSH PRIVILEGES;
EOF
