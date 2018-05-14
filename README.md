# Symfony Flex: dockerized - 🐋 = 💕

This is a template for bootstrapping your own [Symfony][symfony] Flex applications
in a [Docker][docker] environment.

## What this environment provides

Out of the box you will get containers optimized for size, using [Alpine Linux][alpine]
with the following components:

- MariaDB, version 10.2
- Redis, version 4.0.9
- PHP with FPM, version 7.2.5
- Composer, version 1.6.5
- NodeJS with Yarn, version 8.11.1

By default this environment does not contain any Symfony or NodeJS project,
as empty projects will automatically be bootstrapped upon starting the container
builds for the 1st time.

## Using the environment

All the usual Symfony and Composer commands can and should be used with Docker.

### Customizing for development

We provide a sample `docker-compose.override.yaml.dist` that can be used to
customize container builds for e.g. developing your applications. In the given
example live code will be mounted as Docker volume instead of having the code
only contained within the built containers.

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

[symfony]: https://symfony.com/
[docker]: https://docker.com/
[alpine]: https://alpinelinux.org/
