help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "help      – Show this help"
	@echo "up        – Start the mysql container locally"
	@echo "down      – Stop the mysql container"
	@echo "dump      – Dump to the local '.sql' file"
	@echo "rollback  – Rollback to local '.sql' file"

up:
	docker compose up --detach

down:
	docker compose down

dump:
	docker compose exec -T mysql mysqldump --user=root --password=secret \
		--lock-all-tables --complete-insert --skip-extended-insert \
		--comments --skip-dump-date --default-character-set=utf8mb4 \
		--databases serlo > docker-entrypoint-initdb.d/001-init.sql

rollback:
	docker compose exec mysql \
		sh -c "pv /docker-entrypoint-initdb.d/001-init.sql | serlo-mysql"
