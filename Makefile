help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "help      – Show this help"
	@echo "up        – Start the mysql container locally"
	@echo "down      – Stop the mysql container"

up:
	docker compose up --detach

down:
	docker compose down
