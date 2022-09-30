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

stop:
	docker-compose -f $(COMPOSE) stop

down:
	docker-compose -f $(COMPOSE) down -v

C := wordpress

shell:
	docker exec -it $(C) bash

S := db.php

curl:
	curl -ik https://localhost:443/$(S)
