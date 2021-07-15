# Symfony Flex: dockerized - 🐋 = 💕 [![Build status][bs-image]][bs-url]

This is a template for bootstrapping your own [Symfony][symfony] Flex applications
in a [Docker][docker] environment. The primary intention here is to provide a
fully self-contained environment.

## What this environment provides

Out of the box you will get containers optimized for size, using [Alpine Linux][alpine]
with the following components:

-   MariaDB, version 10.5.9
-   Postgres, version 12.7
-   Redis, version 6.2.4
-   PHP with FPM, version 7.4.21
-   Composer, version 2.1.3
-   NodeJS with Yarn, version 14.17.0
-   Nginx, version 1.20.1
-   Symfony, version 5

By default this environment does not contain any Symfony or NodeJS project,
as empty projects will automatically be bootstrapped upon starting the container
builds for the 1st time.

## Using the environment

All the usual Symfony and Composer commands can and should be used with `docker`
/ `docker-compose`.

This repository also works when using `podman` / `podman-compose`.

### Customizing for development

We provide a sample `docker-compose.override.yaml.dist` that can be used to
customize container builds for e.g. developing your applications. In the given
example live code will be mounted as Docker volume instead of having the code
only contained within the built containers.

To start working on a project, copy `docker-compose.override.yaml.dist` to
`docker-compose.override.yaml` and adapt it for your specific project.

### Configuring the environment

A sample `.env.dist` file is provided containing settings for MariaDB, Symfony
Flex specific settings will be added automatically upon installing recipes.

### Building the containers

```console
docker-compose build
```

### Starting the environment

```console
docker-compose up -d
```

### Shutting down and destroying the environment

```console
docker-compose down --remove-orphans --volumes
```

If you want to retain volumes, remove `--volumes` from the above command.

### Executing Composer commands

```console
docker-compose exec php composer ...
```

### Executing Symfony commands

```console
docker-compose exec php bin/console ...
```

[bs-image]: https://travis-ci.com/kogitoapp/symfony-flex-docker.svg?branch=master
[bs-url]: https://travis-ci.com/kogitoapp/symfony-flex-docker
[symfony]: https://symfony.com/
[docker]: https://docker.com/
[alpine]: https://alpinelinux.org/
