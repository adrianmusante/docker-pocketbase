SHELL=/bin/bash
MAKEFLAGS+=-s

LOCAL_DIR=$(PWD)/_local
DATA_DIR=$(LOCAL_DIR)/data

reset-volumes:
	docker compose down || true; \
	POCKETBASE_DIR=$(DATA_DIR)/pocketbase && sudo rm -rdf $$POCKETBASE_DIR \
		&& sudo mkdir -p $$POCKETBASE_DIR && sudo chown -R 1001:1001 $$POCKETBASE_DIR

run:
	docker compose down || true; docker compose up --build -V --force-recreate

run-detach:
	docker compose down || true; docker compose up --build -V --force-recreate -d

build-multi:
	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t adrianmusante/pocketbase:0.0.0 pocketbase

build-local:
	docker buildx build --load -t adrianmusante/pocketbase:0.0.0 pocketbase

logs:
	docker compose logs -f
