The Container file installs all the dependencies for laravel and installs composer and laravel.

compose file also contains services for postgresql and mysql if you want to use them. Put all your projects inside the apps directory in the root of this template. You can rename it by changing the name apps in volume of docker-compose file.

laravel services uses the host network_mode as that is the only option that works fine with default config laravel starter kit generates.

To run the dev env
```
podman-compose up -d
podman exec -it laravel-dev-env /bin/sh
```
