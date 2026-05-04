SSH_HOST=dulwich.io
SSH_PORT=22
SSH_USER=jelmer
SSH_TARGET_DIR=/var/www/dulwich.io

help:
	@echo 'Makefile for the Dulwich website (MkDocs)'
	@echo ''
	@echo 'Usage:'
	@echo '   make html          build the site into output/'
	@echo '   make serve         serve site at http://localhost:8000'
	@echo '   make clean         remove generated files'
	@echo '   make rsync_upload  upload via rsync+ssh'
	@echo '   make docker        build and push container image'

html:
	mkdocs build

serve:
	mkdocs serve

clean:
	rm -rf output/

rsync_upload: html
	rsync -e "ssh -p $(SSH_PORT)" -P -rvzc --exclude docs --exclude apidocs --delete output/ $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR) --cvs-exclude

docker:
	podman build --load -t ghcr.io/dulwich/homepage .
	podman push ghcr.io/dulwich/homepage

.PHONY: html help clean serve rsync_upload docker
