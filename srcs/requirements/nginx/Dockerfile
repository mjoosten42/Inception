#syntax=docker/dockerfile:1.4
# Allow dockerfile heredocs

# Not allowed to do FROM nginx
FROM debian:buster

ARG DOMAIN_NAME

# Install nginx and openssl
# Create a self-signed certicate.
RUN <<EOF
	apt-get update
	apt-get install -y nginx openssl
	openssl req -x509 -newkey rsa:4096 -nodes	\
		-keyout /etc/nginx/key.pem				\
		-out /etc/nginx/crt.pem					\
		-subj "/CN=$DOMAIN_NAME"
EOF

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=1s CMD [ "nginx", "-t" ]

# Daemon off: run in foreground so the container doesn't exit immediately
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
