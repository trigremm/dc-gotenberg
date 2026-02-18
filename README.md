# dc-gotenberg

Gotenberg 8 — document conversion API (port 7100).

## Quick start

```bash
cp .env.sample .env
vim .env
make up
```

## Commands

### Lifecycle

```
make d          # deploy (git pull + recreate)
make r          # recreate (build + stop + up)
make up         # start
make stop       # stop
make down       # stop and remove
make ps         # status
make l          # follow logs
```

### Gotenberg

```
make gotenberg-shell    # bash shell in gotenberg container
make gotenberg-health   # check health endpoint
make test               # run smoke tests (health, docx→pdf conversion)
```

## Usage example

```bash
curl -X POST http://localhost:7100/forms/libreoffice/convert \
  --form files=@document.docx -o document.pdf
```
