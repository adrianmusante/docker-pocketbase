# docker-pocketbase

PocketBase&trade; is an open source backend consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Documentation:

- [PocketBase](https://pocketbase.io/docs)


## Docker registry

The recommended way to get the PocketBase&trade; Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/adrianmusante/pocketbase).

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/adrianmusante/pocketbase/tags/) in the Docker Hub Registry.

- [`0`, `0.34`, `latest` (pocketbase/Dockerfile)](https://github.com/adrianmusante/docker-pocketbase/blob/main/pocketbase/Dockerfile)


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

- `POCKETBASE_DEBUG`: Verbose mode. Default: **false**
- `POCKETBASE_PORT_NUMBER`: PocketBase&trade; server port number. Default: **8090**
- `POCKETBASE_OPTS`: Additional options for bootstrap server. No defaults.
- `POCKETBASE_ADMIN_EMAIL`: Admin user email. No defaults.
- `POCKETBASE_ADMIN_PASSWORD`: Admin user password. It is possible to use Docker secrets to define the value or set the `POCKETBASE_ADMIN_PASSWORD_FILE` variable which will contain the path where the value is stored. No defaults.
- `POCKETBASE_ADMIN_UPSERT`: If set to `true`, the admin user always is set from environment variables before the server starts. Otherwise, set to `false` for only create in the first startup. Default: **true**

##### Encryption

- `POCKETBASE_ENCRYPTION_KEY`: The variable is used to encrypt the applications settings in PocketBase's database. By default, these settings are stored as plain JSON text, which may not be suitable for production environments where security is a concern. When you set this variable to a value, PocketBase will use it to encrypt the settings before storing them in the database. This provides an additional layer of protection against unauthorized access to your application's sensitive data, such as OAuth2 client secrets and SMTP passwords. (ref.: [pocketbase.io](https://pocketbase.io/docs/going-to-production/#enable-settings-encryption))
- `POCKETBASE_ENCRYPTION_KEY_FILE`: Alternative to `POCKETBASE_ENCRYPTION_KEY` environment variable. If Docker manages the secret, this variable is used to reference the name with which the secret was created. An absolute path can also be specified if the secret was mounted as a file using a volume. Default: **POCKETBASE_ENCRYPTION_KEY**

##### Directories

- `POCKETBASE_WORKDIR` Persistence base directory. Default: **/pocketbase**
- `POCKETBASE_DATA_DIR` PocketBase data directory. Default: **${POCKETBASE_WORKDIR}/data**
- `POCKETBASE_MIGRATION_DIR` The directory with the user defined migrations. Default: **${POCKETBASE_WORKDIR}/migrations**
- `POCKETBASE_PUBLIC_DIR` The directory to serve static files. Default: **${POCKETBASE_WORKDIR}/public**
- `POCKETBASE_HOOK_DIR` The directory with the JS app hooks. Default: **${POCKETBASE_WORKDIR}/hooks**
