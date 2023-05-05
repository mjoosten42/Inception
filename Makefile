COMPOSE := srcs/docker-compose.yml

# TODO :switch
# export VOLUME_PATH := /home/$(USER)/data
export VOLUME_PATH := /Users/$(USER)/Desktop/Inception/data

# echo '127.0.0.1 mjoosten.42.fr' >> /etc/hosts

up: | $(VOLUME_PATH)
	docker compose -f $(COMPOSE) up --build -d

$(VOLUME_PATH):
	mkdir -p $@/db
	mkdir -p $@/wp

down:
	docker compose -f $(COMPOSE) down

start:
	docker compose -f $(COMPOSE) start

stop:
	docker compose -f $(COMPOSE) stop

prune:
	docker compose -f $(COMPOSE) down -v
	docker system prune -af
	$(RM) -r data

re: prune
	make up

C := wordpress

shell:
	docker exec -itu 0 $(C) bash

curl:
	curl -ik https://localhost:443/$(S)
