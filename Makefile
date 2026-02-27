up:
	podman-compose up -d

down:
	podman-compose down

shell:
	podman exec -it laravel-dev-env /bin/sh

build:
	podman-compose build --no-cache

.PHONY: up down shell build
