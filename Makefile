help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "help      – Show this help"
	@echo "up        – Start the mysql container locally"
	@echo "down      – Stop the mysql container"
	@echo "dump      – Dump to the local '.sql' file"
	@echo "mysql     – Connect to local MySQL server with a shell"
	@echo "rollback  – Rollback to local '.sql' file"

up: unzip
	docker compose up --build --detach

down:
	docker compose down

dump:
	docker compose exec -T mysql mysqldump --user=root --password=secret \
		--lock-all-tables --default-character-set=utf8mb4 \
		--databases serlo > docker-entrypoint-initdb.d/001-init.sql

zip:
	tar -zcvf docker-entrypoint-initdb.tar docker-entrypoint-initdb.d

unzip:
	tar -xvzf docker-entrypoint-initdb.tar

mysql:
	docker compose exec -it mysql serlo-mysql

rollback:
	docker compose cp docker-entrypoint-initdb.d/001-init.sql \
		mysql:/docker-entrypoint-initdb.d/001-init.sql
	docker compose exec -it mysql mysql \
		--user=root --password=secret -e \
		"DROP DATABASE IF EXISTS serlo; CREATE DATABASE serlo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;"
	docker compose exec mysql \
		sh -c "pv /docker-entrypoint-initdb.d/001-init.sql | serlo-mysql"
