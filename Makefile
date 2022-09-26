COMPOSE := srcs/docker-compose.yml

VOLUME_PATH := /Users/mjoosten/Desktop/Inception/data
# VOLUME_PATH := /home/mjoosten/data

# echo '127.0.0.1 mjoosten.42.fr' >> /etc/hosts

up: | $(VOLUME_PATH)
	docker-compose -f $(COMPOSE) up --build -d

$(VOLUME_PATH):
	mkdir -p $@/db
	mkdir -p $@/wp
	cp info.php $@/wp/
	cp favicon.ico $@/wp/

stop:
	docker-compose -f $(COMPOSE) stop

down:
	docker-compose -f $(COMPOSE) down
	docker volume rm $$(docker volume ls -q)
	$(RM) -r data

prune:
	docker system prune -af

C := mariadb

shell:
	docker exec -it $(C) bash

curl:
	curl -k https://localhost:443
