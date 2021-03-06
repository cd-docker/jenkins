.PHONY: agent jenkins clean

agent:
	docker-compose build agent
	docker-compose push agent

jenkins:
	docker-compose build --pull docker ngrok
	docker volume create --name=jenkins-data
	docker-compose up -d jenkins
	docker-compose logs -f jenkins

clean:
	docker-compose down -v
	docker images -q -f dangling=true -f label=application=jenkins | xargs -I ARGS docker rmi -f --no-prune ARGS

# Recommended settings
.ONESHELL:
.SILENT:
SHELL=/bin/bash
.SHELLFLAGS = -ceo pipefail