#syntax=docker/dockerfile:1.3-labs
# Allow dockerfile heredocs

FROM debian:buster

# Install php
RUN <<EOF
    apt-get update
    apt-get install -y php-fpm php-mysql
    mkdir /run/php
EOF

# Add our configuration to the pool
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# Manually start php-fpm
# It usually starts automatically but we're missing an init process
# -F: --nodaemonize AKA run in foreground
ENTRYPOINT php-fpm7.3 -F
