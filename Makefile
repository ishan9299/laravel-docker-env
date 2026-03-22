up:
	podman-compose up -d

down:
	podman-compose down
	# podman stop laravel-dev-env laravel-mysql laravel-postgres

shell: up
	podman exec -it laravel-dev-env /bin/sh

build:
	podman-compose build --no-cache

.PHONY: up down shell build
