COMPOSE := srcs/docker-compose.yml

VOLUME_PATH := /Users/mjoosten/Desktop/Inception/data
# VOLUME_PATH := /home/mjoosten/data

up: | $(VOLUME_PATH)
	docker-compose -f $(COMPOSE) up --build -d

$(VOLUME_PATH):
	mkdir -p $@/db
	mkdir -p $@/wp
	cp index.php $@/wp/
	cp favicon.ico $@/wp/

stop:
	docker-compose -f $(COMPOSE) stop

down:
	docker-compose -f $(COMPOSE) down

prune:
	docker system prune -f

C := wordpress

shell:
	docker exec -it $(C) bash

curl:
	curl -k https://localhost:443

ssl:
	openssl s_client -connect localhost:443
