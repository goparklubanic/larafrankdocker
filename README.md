# SETUP LARAVEL SERVED BY FRANKENPHP IN DOCKER CONTAINER

## MODIFY DOCKER-COMPOSE.YML ENTRIES

You can modify the content of docker-compose.yml according to your need. Keep the concistency when naming the service and container name, because it used by another service.

## SETUP LARAVEL PROJECT

Frankenphp host everything in app/public folder. So, maka app as laravel project name.
Use :

`composer create-project laravel/laravel app`

or

`composer create-project --prefer-dist laravel/laravel:^10`

for specific laravel version, in this case is 10.

## ADJUST .env FILE

Make sure the value of DB_CONNECTION, DB_HOST, DB_DATABASE, DB_USERNAME, and DB_PASSWORD in the .inv file has the same value as it in docker-compose.yml file database environment. The DB_HOST sould refer to database service name in docker-compose.yml

## BUILD THE STACK

Run `docker compose up -d --build` after everything is ready.

## TWEAK THE LARAVEL

Get into the frankenphp container, in this project named frankenapp and do some tweak for laravel.

1. `docker exec -it frankenapp bash`
2. `composer dump-autoload`
3. `php artisan config:clear && php artisan config:cache`

## DISCLAIMER

This stack use PHP 8.2 and laravel 10. If you have different version, then you need to do some tweaks, mainly if the laravel or it's container won't works.
