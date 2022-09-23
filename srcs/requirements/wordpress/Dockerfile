FROM debian:buster

# Install php
RUN apt-get update && apt-get install -y php-fpm php-mysql

# Add our configuration to the pool
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# This file is usually created during startup, but we're doing it manually
RUN mkdir /run/php

# Manually start php-fpm
# It usually starts automatically but we're missing an init process
# -F: --nodaemonize AKA run in foreground
ENTRYPOINT php-fpm7.3 -F
