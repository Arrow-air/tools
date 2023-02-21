# Local Development tools

In some cases you want to have the Arrow Services running locally, in order to validate your code.
The docker-compose.yml file provides you all that is needed to run the services on your local machine (or anywhere else).

## Settings

Docker compose will use the values provided in an `.env` file to pass environment variables to the docker images.
If you need to use a specific docker tag, use a local docker image or want to bind a different port, you can pass those settings through this file.
An `.env-example` file has been provided in this directory. Start with copying this file to `.env` and make changes if needed.

```
cp .env-example .env
```

## Usage

The docker compose file can be used in several ways.
Dependencies are being used, making sure all required services are running in order for a specific service to run.

### Run everything
To run the services in the background, you can run:
```
docker compose up -d
```

### Run a specific service
To run a specific service (including it's dependencies), simply run:
```
docker compose up svc-<service> -d 
```

example, running the storage service:
```
docker compose up svc-storage  -d 
```

### Cleaning up
To shut down and clean up the containers:
```
docker compose down
```
