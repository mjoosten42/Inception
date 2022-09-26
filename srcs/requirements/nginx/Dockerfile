#syntax=docker/dockerfile:1.3-labs
# Allow dockerfile heredocs

# Not allowed to do FROM nginx
FROM debian:buster

# Install nginx and openssl
# Create a self-signed certicate. It has no value whatsoever, but we can get the browser/curl to accept it
# req:				request
# -x509:			self-signed
# newkey rsa:4096:	Create a new key with 4096 bits
# -nodes:			Do not encrypt private key
# -keyout			Key output file
# -out				Certificate output file
# -subj				Metadata
RUN <<EOF
    apt-get update
    apt-get install -y nginx openssl
    openssl req -x509 -newkey rsa:4096 -nodes -keyout /etc/nginx/key.pem -out /etc/nginx/crt.pem -subj "/C=TE/ST=Mondstadt/L=Mondstadt/O=Cat's Tail/CN=localhost"
EOF

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Daemon off: run in foreground so the container doesn't exit immediately
ENTRYPOINT nginx -g "daemon off;"
