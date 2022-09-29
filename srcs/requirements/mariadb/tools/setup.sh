# SQL files can't read env, so we'll use a heredoc

# This doesn't actually set a root password
# Disallow remote root login
# Remove test database
# Remove anonymous users
mysql_secure_installation << EOF

	N
	Y
	Y
	Y
	Y
EOF

mariadb << EOF
	SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');
	CREATE DATABASE IF NOT EXISTS wordpress;
	CREATE OR REPLACE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; 
	GRANT ALL ON mysql.user TO '$MYSQL_USER'@'%';
	FLUSH PRIVILEGES;
EOF
