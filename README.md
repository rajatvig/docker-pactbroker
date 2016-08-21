### Pact Broker

#### Overview
This image run the [Pact Broker](https://github.com/bethesque/pact_broker) in a Docker Container.
To run the container, an instance of postgresql is required.

This uses Puma with Nginx and is inspired by the existing docker image for [Pact Broker](https://github.com/DiUS/pact_broker-docker)

#### How-to/usage

Using the image with Docker Compose

```yml
version: '2'
services:
  pact_broker:
    image: rajatvig/pactbroker:latest
    hostname: broker
    domainname: docker.local
    environment:
      PACT_BROKER_DATABASE_USERNAME: pactbroker
      PACT_BROKER_DATABASE_PASSWORD: password
      PACT_BROKER_DATABASE_HOST: db.docker.local
      PACT_BROKER_DATABASE_NAME: pactbroker
    ports:
      - "80:80"
    depends_on:
      - db
    links:
      - db:db.docker.local
  db:
    image: postgres
    hostname: db
    domainname: docker.local
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_USER: pactbroker
      POSTGRES_DB: pactbroker
    ports:
      - "5432:5432"
```

```bash
docker-compose up
```
