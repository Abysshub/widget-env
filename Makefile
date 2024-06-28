.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_WIDGET=widget

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

ps: ## Show containers.
	@docker compose ps

build: ## Build all containers
	@docker compose build

start: ## Start all containers
	@docker compose up

stop: ## Stop all containers
	@docker compose stop

restart: stop start ## Restart all containers

init:  ## Build & create all container
	make build
	make start

fresh:  ## Destroy & recreate all container
	make stop
	make build
	make start

ssh:
	docker exec -it ${CONTAINER_PHP} sh

