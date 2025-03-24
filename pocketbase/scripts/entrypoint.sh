#!/bin/sh
set -eo pipefail

echo "Running PocketBase v$POCKETBASE_VERSION (build: $BUILD_TAG)"

. "$POCKETBASE_HOME/scripts/pocketbase-env.sh"

debug "USER: $(id)"
debug "HOSTNAME: $(hostname)"

if [ -n "$POCKETBASE_ENCRYPTION_KEY" ]; then
  POCKETBASE_OPTS="--encryptionEnv=POCKETBASE_ENCRYPTION_KEY $POCKETBASE_OPTS"
fi

if is_debug_enabled; then
  POCKETBASE_OPTS="--dev $POCKETBASE_OPTS"
fi

set --  --dir "$POCKETBASE_DATA_DIR" \
        --publicDir "$POCKETBASE_PUBLIC_DIR" \
        --hooksDir "$POCKETBASE_HOOK_DIR" \
        --migrationsDir "$POCKETBASE_MIGRATION_DIR" \
        $POCKETBASE_OPTS "$@"

debug "ARGUMENTS: $*"

if [ -n "$POCKETBASE_ADMIN_EMAIL" ] && [ -n "$POCKETBASE_ADMIN_PASSWORD" ]; then
  if ! is_boolean_yes "${POCKETBASE_ADMIN_UPSERT}" && is_app_initialized; then
    debug "An admin user was provided but the application has already been initialized. The provided admin user will not be set."
  else
    debug "Setting admin user '$POCKETBASE_ADMIN_EMAIL' with password '$POCKETBASE_ADMIN_PASSWORD'"
    if ! pocketbase superuser upsert "$@" "$POCKETBASE_ADMIN_EMAIL" "$POCKETBASE_ADMIN_PASSWORD"; then
      error "Failed to set admin user: $POCKETBASE_ADMIN_EMAIL"
      exit 1
    fi
  fi
fi

exec pocketbase serve --http=0.0.0.0:$POCKETBASE_PORT_NUMBER "$@"
