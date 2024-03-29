# Change log

This list contains all the changes which went into the project, including issues
and further references.

Items starting with `DEPRECATION` are important deprecation notices.

## v1.1.0 (2021-07-15)

-   [Changed] version to 1.1.0
-   [Added] Makefile for Symfony workflow
-   [Changed] to new container images
    -   [Changed] to NodeJS 14.17.3
    -   [Changed] to PHP 7.4.21
-   [Changed] to use prebuilt Postgres Alpine image
-   [Changed] to APCU 5.1.20
-   [Improved] handling of composer install
-   [Fixed] Symfony CLI deployment

## v1.0.0 (2021-06-15)

-   [Changed] version to 1.0.0
-   [Added] Symfony CLI
-   [Changed] to new container images
    -   [Changed] to Composer 2.1.3
    -   [Changed] to PHP 7.4.20
-   [Improved] podman support
    The Symfony Flex Docker Environment can now be used with docker/docker-compose
    and podman/podman-compose for rootless development!
-   [Added] note about podman support
-   [Changed] to Symfony 5.2
-   [Changed] to use full registry path to support podman
-   [Changed] to new container images
    -   [Changed] to MariaDB 10.5.9
    -   [Changed] to nginx 1.20.1
    -   [Changed] to NodeJS 14.17.0
    -   [Changed] to PHP 7.4.19
    -   [Changed] to Postgres 12.7
-   [Changed] to Alpine 3.13 based images
-   [Fixed] missing volume
-   [Changed] to newer versions
-   [Changed] to newer versions
-   [Fixed] missing MySQL PDO driver
-   [Fixed] MariaDB health check
-   [Added] Redis environment variables
-   [Added] PHP redis extension
-   [Fixed] Postgres health check
-   [Added] SMTP mail catcher MailHog
-   [Added] health check / Postgres PHP mod
-   [Added] Postgres 12.3
-   [Removed] generated file
-   [Improved] environment
    -   [Changed] to MariaDB 10.4
    -   [Changed] to Redis 5.0
    -   [Changed] to PHP 7.4
    -   [Changed] to Composer 1.10
    -   [Changed] to NodeJS 12.18
    -   [Changed] to nginx 1.18
    -   [Changed] to Symfony 5
-   [Changed] to use pre-built images for redis/mariadb
-   [Fixed] nginx configuration
-   [Changed] to composer version 1.8.0
-   [Changed] to current versions
-   [Added] container names
-   [Changed] to PHP 7.2.7/Composer 1.7.0
-   [Changed] MariaDB to Alpine 3.8
-   [Changed] to PHP 7.2.7
-   [Fixed] entrypoint
-   [Fixed] MariaDB build
-   [Removed] yarn install
-   [Changed] Docker container to current versions
-   [Added] option for local SMTP catcher
    Seeing what you would mail out is nice
-   [Added] dedicated mounts for bundles and built assets
    This makes deployment a lot easier since you can just use a shared
    volume.
-   [Changed] to add application to container
-   [Changed] NodeJS to version 8.11.2
-   [Added] WORKDIR to nginx
    This just ensures we use the same one for all containers.
-   [Added] GD module to PHP-FPM by default
-   [Added] multipe GPG sources for key verification
-   [Added] build status to README
-   [Added] Travis CI build pipeline
-   [Improved] default configuration
-   [Added] service dependencies and override tweaks
    Override tweaks show how to
    -   locally access Redis/MariaDB
    -   mount user composer settings, can e.g. be used to supply github
-   [Added] basic Flex and Webpack configuration
-   [Added] git ignore list
-   [Added] initial documentation
-   [Added] Docker environment for Symfony flex
