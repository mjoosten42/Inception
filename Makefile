include srcs/.env

COMPOSE := srcs/docker-compose.yml

up: | $(VOLUME_PATH)
	docker compose -f $(COMPOSE) up --build -d

$(VOLUME_PATH):
	mkdir -p $@/db $@/wp
	chown -R $(MYSQL):$(MYSQL) $@/db
	chown -R $(WWW_DATA):$(WWW_DATA) $@/wp

down:
	docker compose -f $(COMPOSE) down

start:
	docker compose -f $(COMPOSE) start

stop:
	docker compose -f $(COMPOSE) stop

reset:
	docker compose -f $(COMPOSE) down -v
	$(RM) -r $(VOLUME_PATH)
	service docker restart

prune:
	docker compose -f $(COMPOSE) down -v
	docker system prune -af
	$(RM) -r $(VOLUME_PATH)

logs:
	docker compose -f $(COMPOSE) logs

config:
	docker compose -f $(COMPOSE) config

re: prune
	make up

C := wordpress

shell:
	docker exec -itu 0 $(C) bash

curl:
	curl -ik https://localhost:443/$(S)

