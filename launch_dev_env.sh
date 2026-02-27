#!/bin/sh

podman-compose up -d
podman exec -it laravel-dev-env /bin/sh
