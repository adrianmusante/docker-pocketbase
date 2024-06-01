#!/bin/sh
set -eo pipefail

echo "Running PocketBase v$POCKETBASE_VERSION for user: $(id)"

. "$POCKETBASE_HOME/scripts/pocketbase-env.sh"

if [ -n "$POCKETBASE_ENCRYPTION_KEY" ]; then
  POCKETBASE_OPTS="--encryptionEnv=POCKETBASE_ENCRYPTION_KEY $POCKETBASE_OPTS"
fi

if is_boolean_yes "$POCKETBASE_DEBUG"; then
  POCKETBASE_OPTS="--dev $POCKETBASE_OPTS"
  set -x
fi
exec pocketbase serve --http=0.0.0.0:$POCKETBASE_PORT_NUMBER \
  --dir "$POCKETBASE_DATA_DIR" \
  --publicDir "$POCKETBASE_PUBLIC_DIR" \
  --hooksDir "$POCKETBASE_HOOK_DIR" \
  --migrationsDir "$POCKETBASE_MIGRATION_DIR" \
  $POCKETBASE_OPTS "$@"
