.PHONY: up stop down logs l ps test

up:
	docker compose up -d

stop:
	docker compose stop

down:
	docker compose down

logs:
	docker compose logs -f
l: logs

ps:
	docker compose ps

test:
	@echo "curl -X POST http://localhost:$${DC_GOTENBERG_PORT:-7300}/forms/libreoffice/convert --form files=@document.docx -o document.pdf"
