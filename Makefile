DOCKER_COMPOSE?=docker-compose
EXEC_PHP?=$(DOCKER_COMPOSE) run --rm php
EXEC_NODE?=$(DOCKER_COMPOSE) run --rm node
CONSOLE=bin/console
PHPCSFIXER?=$(EXEC_PHP) vendor/bin/php-cs-fixer

.DEFAULT_GOAL := help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Project setup
##------------------------------------------------------------------------------
prepare: build                                                                  ## Build the containers

start: up db assets                                                             ## Start the containers and setup all things

stop:                                                                           ## Stop and remove the containers
	$(DOCKER_COMPOSE) down

clean: assets-clean                                                             ## Delete 3rd party dependencies
	rm -rf var vendor node_modules

reset: clean prepare		                                                    ## Remove any changes, start from scratch

##
## Database
##------------------------------------------------------------------------------
wait-for-db:
	$(EXEC_PHP) php -r "set_time_limit(60);for(;;){if(@fsockopen('postgres',5432)){break;}echo \"Waiting for PostgreSQL\n\";sleep(1);}"

db: db-recreate                                                                 ## Reset and reload the database
	$(EXEC_PHP) $(CONSOLE) doctrine:migrations:migrate -n
#	$(EXEC_PHP) $(CONSOLE) doctrine:fixtures:load -n

db-diff: wait-for-db                                                            ## Generate a migration
	$(EXEC_PHP) $(CONSOLE) make:migration

db-schema-test: db-recreate                                                     ## Resets DB, migrates and shows pending schema changes
	$(EXEC_PHP) $(CONSOLE) doctrine:migrations:migrate -n
	$(EXEC_PHP) $(CONSOLE) doctrine:schema:update --dump-sql

db-schema-preview: wait-for-db                                                  ## Show pending schema changes
	$(EXEC_PHP) $(CONSOLE) doctrine:schema:update --dump-sql

db-fixtures: wait-for-db                                                        ## Load sample fixtures
	$(EXEC_PHP) $(CONSOLE) doctrine:fixtures:load -n

db-migrate: wait-for-db                                                         ## Migrate to latest schema
	$(EXEC_PHP) $(CONSOLE) doctrine:migration:migrate -n

db-rollback: wait-for-db                                                        ## Rollback the latest executed migration
	$(EXEC_PHP) $(CONSOLE) doctrine:migration:migrate prev -n

db-load: wait-for-db                                                            ## Reset the database fixtures
	$(EXEC_PHP) $(CONSOLE) doctrine:fixtures:load -n

db-validate: wait-for-db                                                        ## Check the ORM mapping
	$(EXEC_PHP) $(CONSOLE) doctrine:schema:validate

db-recreate: wait-for-db                                                        ## Creates a blank database
	$(EXEC_PHP) $(CONSOLE) doctrine:database:drop --force --if-exists
	$(EXEC_PHP) $(CONSOLE) doctrine:database:create --if-not-exists

##
## Assets
##------------------------------------------------------------------------------
assets: permissions                                                             ## Build assets
	$(EXEC_NODE) npm run dev
	$(EXEC_PHP) $(CONSOLE) assets:install

assets-prod: permissions                                                        ## Build assets
	$(EXEC_NODE) npm run build
	$(EXEC_PHP) $(CONSOLE) assets:install --env=prod

assets-clean:                                                                   ## Removes generated assets
	rm -rf public/build public/bundles

##
## Translations
##------------------------------------------------------------------------------
translation-update:                                                             ## Extract and update translations
	$(EXEC_PHP) $(CONSOLE) translation:update --output-format=xlf --force en

##
## Tests
##------------------------------------------------------------------------------
test: tu                                                                        ## Run the PHP and the Javascript tests

tu:                                                                             ## Run the PHP unit tests
	$(EXEC_PHP) vendor/phpunit

##
## Helper functions
## -----------------------------------------------------------------------------
permissions:                                                                    ## Reset permissions for generated files
	$(EXEC_PHP) mkdir -p var/ public/build/ public/bundles/
	$(EXEC_PHP) chmod -R 777 var/ public/build/ public/bundles/
	$(EXEC_PHP) chown -R www-data var/ public/build/ public/bundles/

tail-dev:                                                                       ## Keep an eye on DEV logs
	$(EXEC_PHP) tail -f var/log/dev.log

# Internal rules
# ------------------------------------------------------------------------------
build:
	$(DOCKER_COMPOSE) pull
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

# What a phony!
# ------------------------------------------------------------------------------
.PHONY: help
.PHONY: prepare start stop clean reset
.PHONY: wait-for-db db db-diff db-schema-test db-schema-preview db-fixtures db-migrate db-rollback db-load db-validate db-recreate
.PHONY: assets assets-prod assets-clean
.PHONY: translation-update
.PHONY: test tu
.PHONY: permissions tail-dev
.PHONY: build up down
