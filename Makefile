POCKETBASE_VERSION=
LOCAL_DIR=$(PWD)/_local
DATA_DIR=$(LOCAL_DIR)/data

reset_volumes:
	docker-compose down || true; \
	POCKETBASE_DIR=$(DATA_DIR)/pocketbase && sudo rm -rdf $$POCKETBASE_DIR && mkdir -p -m 777 $$POCKETBASE_DIR && sudo chown -R 1001:1001 $$POCKETBASE_DIR

run:
	docker-compose down || true; docker-compose up --build -V --force-recreate

run_detach:
	docker-compose down || true; docker-compose up --build -V --force-recreate -d

logs:
	docker-compose logs -f
