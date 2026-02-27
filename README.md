# build the image

podman compose up -d --build
podman compose run --rm laravel sh

# inside the image create the laravel project

laravel new example-app
