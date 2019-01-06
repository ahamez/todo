.PHONY: help

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`
BUILD ?= `git rev-parse --short HEAD`

help:
	@echo "$(APP_NAME):$(APP_VSN)"

build: ## Build the Docker image
	docker build --build-arg APP_NAME=$(APP_NAME) --build-arg APP_VSN=$(APP_VSN) -t $(APP_NAME):$(APP_VSN)-$(BUILD) -t $(APP_NAME):latest .

run: ## Run the app in Docker
	docker run --rm --env-file config/docker.env --expose 9090 -p 9090:9090 --rm -it $(APP_NAME):latest
