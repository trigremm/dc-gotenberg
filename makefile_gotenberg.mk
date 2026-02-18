# makefile_gotenberg.mk
# Gotenberg commands

GOTENBERG_URL := http://localhost:$${DC_GOTENBERG_PORT:-7100}

.PHONY: gotenberg-shell gotenberg-health test

gotenberg-shell:
	$(DC_BIN) exec gotenberg bash

gotenberg-health:
	curl -f $(GOTENBERG_URL)/health

test:
	@echo "Starting gotenberg..."
	$(DC_BIN) up -d
	@echo "Waiting for healthcheck..."
	@for i in 1 2 3 4 5 6; do \
		curl -sf $(GOTENBERG_URL)/health >/dev/null 2>&1 && break || sleep 5; \
	done
	@echo "Test health endpoint..."
	curl -sf $(GOTENBERG_URL)/health > /dev/null && echo "PASS: health" || (echo "FAIL: health" && exit 1)
	@echo "Test docx to pdf conversion..."
	curl -sf -X POST $(GOTENBERG_URL)/forms/libreoffice/convert --form files=@tests/test_1p.docx -o /tmp/gotenberg_test.pdf && echo "PASS: docx→pdf" || (echo "FAIL: docx→pdf" && exit 1)
	@test -s /tmp/gotenberg_test.pdf && echo "PASS: output file not empty" || (echo "FAIL: output file empty" && exit 1)
	@rm -f /tmp/gotenberg_test.pdf
	@echo ""
	@echo "All tests passed!"
