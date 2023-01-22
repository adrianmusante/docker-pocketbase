#!/bin/sh

echo "Running PocketBase v$POCKETBASE_VERSION for user: $(id)"

. "$POCKETBASE_HOME/scripts/pocketbase-env.sh"
. "$POCKETBASE_HOME/scripts/libutil.sh"

if is_boolean_yes "$POCKETBASE_DEBUG"; then
  POCKETBASE_OPTS="--debug $POCKETBASE_OPTS"
  set -x
fi
exec pocketbase serve --http=0.0.0.0:$POCKETBASE_PORT_NUMBER \
  --dir "$POCKETBASE_DATA_DIR" \
  --publicDir "$POCKETBASE_PUBLIC_DIR" \
  --migrationsDir "$POCKETBASE_MIGRATION_DIR" \
  $POCKETBASE_OPTS "$@"
