

# docker-pocketbase

PocketBase&trade; es un backend de código abierto que consiste en una base de datos incrustada (SQLite) con suscripciones en tiempo real, gestión de autenticación integrada, una interfaz de panel de control conveniente y una API simple tipo REST.

## Documentación:

- [PocketBase](https://pocketbase.io/docs)


## Registro de Docker

La forma recomendada de obtener la imagen de Docker de PocketBase&trade; es descargar la imagen precompilada desde el [Registro de Docker Hub](https://hub.docker.com/r/adrianmusante/pocketbase).

Para usar una versión específica, puedes descargar una etiqueta versionada. Puedes ver la [lista de versiones disponibles](https://hub.docker.com/r/adrianmusante/pocketbase/tags/) en el Registro de Docker Hub.

- [`0`, `0.39`, `latest` (pocketbase/Dockerfile)](https://github.com/adrianmusante/docker-pocketbase/blob/main/pocketbase/Dockerfile)


## Configuración

### Variables de entorno

Al iniciar la imagen de PocketBase&trade;, puedes ajustar la configuración de la instancia pasando una o más variables de entorno ya sea en el archivo docker-compose o en la línea de comandos de `docker run`. Si deseas agregar una nueva variable de entorno:

- Para docker-compose, agrega el nombre y el valor de la variable en la sección de la aplicación en el archivo [`docker-compose.yml`](https://github.com/adrianmusante/docker-pocketbase/blob/main/docker-compose.example.yml) presente en este repositorio:

    ```yaml
    pocketbase:
      ...
      environment:
        - USER_DEFINED_KEY=custom_value
      ...
    ```

- Para ejecución manual, agrega una opción `--env` con cada variable y valor:

    ```console
    $ docker run -d --name pocketbase -p 80:8090 \
      --env USER_DEFINED_KEY=custom_value \
      --network pocketbase_network \
      --volume /path/to/pocketbase-persistence:/pocketbase \
      adrianmusante/pocketbase:latest
    ```

Variables de entorno disponibles:

##### Configuración general

- `POCKETBASE_DEBUG`: Modo detallado (verbose). Predeterminado: **false**
- `POCKETBASE_PORT_NUMBER`: Número de puerto del servidor PocketBase&trade;. Predeterminado: **8090**
- `POCKETBASE_OPTS`: Opciones adicionales para la inicialización del servidor. Sin predeterminados.
- `POCKETBASE_ADMIN_EMAIL`: Correo electrónico del usuario administrador. Sin predeterminados.
- `POCKETBASE_ADMIN_PASSWORD`: Contraseña del usuario administrador. Es posible usar secretos de Docker para definir el valor o establecer la variable `POCKETBASE_ADMIN_PASSWORD_FILE`, que contendrá la ruta donde se almacena el valor. Sin predeterminados.
- `POCKETBASE_ADMIN_UPSERT`: Si se establece en `true`, el usuario administrador siempre se configura desde las variables de entorno antes de que inicie el servidor. De lo contrario, establéncelo en `false` para que solo se cree en el primer arranque. Predeterminado: **true**

##### Cifrado

- `POCKETBASE_ENCRYPTION_KEY`: Esta variable se utiliza para cifrar la configuración de la aplicación en la base de datos de PocketBase. De forma predeterminada, esta configuración se almacena como texto JSON sin formato, lo cual puede no ser adecuado para entornos de producción donde la seguridad es una preocupación. Cuando estableces esta variable en un valor, PocketBase la utilizará para cifrar la configuración antes de almacenarla en la base de datos. Esto proporciona una capa adicional de protección contra el acceso no autorizado a datos sensibles de tu aplicación, como los secretos de cliente OAuth2 y las contraseñas SMTP. (ref.: [pocketbase.io](https://pocketbase.io/docs/going-to-production/#enable-settings-encryption))
- `POCKETBASE_ENCRYPTION_KEY_FILE`: Alternativa a la variable de entorno `POCKETBASE_ENCRYPTION_KEY`. Si Docker gestiona el secreto, esta variable se utiliza para hacer referencia al nombre con el que se creó el secreto. También se puede especificar una ruta absoluta si el secreto se montó como un archivo utilizando un volumen. Predeterminado: **POCKETBASE_ENCRYPTION_KEY**

##### Directorios

- `POCKETBASE_WORKDIR` Directorio base de persistencia. Predeterminado: **/pocketbase**
- `POCKETBASE_DATA_DIR` Directorio de datos de PocketBase. Predeterminado: **${POCKETBASE_WORKDIR}/data**
- `POCKETBASE_MIGRATION_DIR` El directorio con las migraciones definidas por el usuario. Predeterminado: **${POCKETBASE_WORKDIR}/migrations**
- `POCKETBASE_PUBLIC_DIR` El directorio para servir archivos estáticos. Predeterminado: **${POCKETBASE_WORKDIR}/public**
- `POCKETBASE_HOOK_DIR` El directorio con los hooks de la aplicación JS. Predeterminado: **${POCKETBASE_WORKDIR}/hooks**
