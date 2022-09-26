#syntax=docker/dockerfile:1.3-labs
# Allow dockerfile heredocs

FROM debian:buster

RUN <<EOF
    apt-get update
    apt-get install -y mariadb-server
    service mysql start
    echo "CREATE USER 'wordpress'@'wordpress';" | mariadb
EOF

ENTRYPOINT sleep 3000