# Docker Wait for Deps

![License](https://img.shields.io/github/license/matteovivona/docker-wait-for-dependencies) [![Docker Pulls](https://img.shields.io/docker/pulls/ducktors/docker-wait-for-dependencies?logo=docker)](https://hub.docker.com/r/ducktors/docker-wait-for-dependencies) ![amd64](https://img.shields.io/badge/arch-linux%2Famd64-brightgreen) ![amd64](https://img.shields.io/badge/arch-linux%2Farm64-brightgreen)

A simple container that puts itself on hold until the other services declared in the docker-compose are accessible via TCP.

Available for `linux/amd64` and `linux/arm64` architectures.

## Example usage:

Sample `docker-compose.yml`:

```yaml
version: '2'
services:
  mongo:
    image: mongo:6
    container_name: mongo
    ports:
      - 27017:27017
    networks:
      - my-network

  redis:
    container_name: redis
    image: redis:6
    ports:
      - 6379:6379
    networks:
      - my-network

  server:
    container_name: server
    image: server
    ports:
      - 3000:3000
    networks:
      - my-network

  start_dependencies:
    image: tehkapa/docker-wait-for-dependencies
    depends_on:
      - mongo
      - redis
    container_name: wait-for-dependencies
    command: mongo:27017 redis:6379
    networks:
      - my-network
```

Then, to guarantee that `mongo` and `redis` are ready before running `server`:

```bash
$ docker-compose run --rm start_dependencies
# Some output from docker compose
$ docker-compose up server
```

By default, there will be a 2 second sleep time between each check. You can modify this by setting the `SLEEP_LENGTH` environment variable:

```yaml
  start_dependencies:
    image: tehkapa/docker-wait-for-dependencies
    environment:
      - SLEEP_LENGTH: 0.5
```

By default, there will be a 300 seconds timeout before cancelling the wait_for. You can modify this by setting the `TIMEOUT_LENGTH` environment variable:

```yaml
  start_dependencies:
    image: tehkapa/docker-wait-for-dependencies
    environment:
      - SLEEP_LENGTH: 1
      - TIMEOUT_LENGTH: 60
```
