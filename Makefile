# https://stackoverflow.com/questions/50817985/docker-tries-to-mkdir-the-folder-that-i-mount

COMPOSE := srcs/docker-compose.yml

# VOLUME_PATH := /home/mjoosten/data
VOLUME_PATH := /Users/mjoosten/Desktop/Inception/data

# echo '127.0.0.1 mjoosten.42.fr' >> /etc/hosts

up: | $(VOLUME_PATH)
	docker-compose -f $(COMPOSE) up --build -d 

$(VOLUME_PATH):
	mkdir -p $@/db
	mkdir -p $@/wp
	cp *.php $@/wp/
	cp favicon.ico $@/wp/

down:
	docker-compose -f $(COMPOSE) down -v

start:
	docker-compose -f $(COMPOSE) start

stop:
	docker-compose -f $(COMPOSE) stop

reset: down
	docker system prune -af
	rm -r data

re: reset
	make up

C := mariadb

shell:
	docker exec -it $(C) bash

S := db.php

curl:
	curl -ik https://localhost:443/$(S)
