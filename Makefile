#!/usr/bin/env make

OS := $(shell uname -s)

docker_bin := $(shell command -v docker 2> /dev/null)
docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

ifeq ($(OS), Darwin)
	echo_bin = $(shell command -v echo 2> /dev/null)
else
	echo_bin = $(shell command -v echo -e 2> /dev/null)
endif

.PHONY : help start stop init up down
.DEFAULT_GOAL := help

help: ## Показать эту подсказку
	@$(echo_bin) "etcd cluster"
	@$(echo_bin) "Maintainer Dennis Y. Parygin (dyp2000@mail.ru)\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[33m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: up ## Запустить проект
	@$(echo_bin) "\n\033[33mКластер etcd стартовал\n"

up: ## Поднять контейнеры
	$(docker_compose_bin) -f ./docker-compose-cluster.yml up --build -d

down: ## Остановить контейнеры
	$(docker_compose_bin) down --remove-orphans

stop: down ## Остановить проект
	@$(echo_bin) "Stop..."

bench: ## Тест производительности
	$(docker_bin) start etcd-benchmark
# 	$(docker_bin) exec -t etcd-benchmark /opt/etcd-benchmark/benchmark --endpoints=10.5.0.10:2379,10.5.0.11:2379,10.5.0.12:2379,10.5.0.13:2379,10.5.0.14:2379 \
# 	--conns=100 --clients=1000 put --key-size=8 --sequential-keys --total=100000 --val-size=256

init: ## Инициализировать КЛАСТЕР
	$(docker_compose_bin) down --remove-orphans
	rm -rf ./etcd/data-1/*
	rm -rf ./etcd/data-2/*
	rm -rf ./etcd/data-3/*
	rm -rf ./etcd/data-4/*
	rm -rf ./etcd/data-5/*

clean: ## Удалить неиспользуемые контейнеры
	$(docker_bin) system prune -f

---------------: ## ---------------
