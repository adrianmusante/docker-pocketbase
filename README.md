# docker-pocketbase

PocketBase&trade; is an open source backend consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Documentation:

- [PocketBase](https://pocketbase.io/docs)


## Docker registry

The recommended way to get the PocketBase&trade; Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/adrianmusante/pocketbase).

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/adrianmusante/pocketbase/tags/) in the Docker Hub Registry.

- [`0`, `0.13`, `latest` (pocketbase/Dockerfile)](https://github.com/adrianmusante/docker-pocketbase/blob/main/pocketbase/Dockerfile)


## Configuration

### Environment variables

When you start the PocketBase&trade; image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the `docker run` command line. If you want to add a new environment variable:

- For docker-compose add the variable name and value under the application section in the [`docker-compose.yml`](https://github.com/adrianmusante/docker-pocketbase/blob/main/docker-compose.example.yml) file present in this repository:

    ```yaml
    pocketbase:
      ...
      environment:
        - USER_DEFINED_KEY=custom_value
      ...
    ```

- For manual execution add a `--env` option with each variable and value:

    ```console
    $ docker run -d --name pocketbase -p 80:8090 \
      --env USER_DEFINED_KEY=custom_value \
      --network pocketbase_network \
      --volume /path/to/pocketbase-persistence:/pocketbase \
      adrianmusante/pocketbase:latest
    ```

Available environment variables:

##### General configuration

- `POCKETBASE_PORT_NUMBER`: PocketBase&trade; server port number. Default: **8090**
- `POCKETBASE_OPTS`: Additional options for bootstrap server. No defaults.
