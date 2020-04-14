.PHONY: agent jenkins clean

agent:
	docker-compose build agent
	docker-compose push agent

jenkins:
	docker-compose build docker
	docker volume create --name=jenkins-data
	docker-compose up -d jenkins
	docker-compose logs -f jenkins

clean:
	docker-compose down -v
	docker system prune --filter label=application=jenkins -f

# Recommended settings
.ONESHELL:
.SILENT:
SHELL=/bin/bash
.SHELLFLAGS = -ceo pipefail