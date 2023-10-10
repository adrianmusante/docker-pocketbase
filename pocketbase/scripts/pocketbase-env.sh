#!/bin/sh

export POCKETBASE_DEBUG="${POCKETBASE_DEBUG:-false}"

# Paths
export POCKETBASE_WORKDIR="${POCKETBASE_WORKDIR:-/pocketbase}"
export POCKETBASE_DATA_DIR="${POCKETBASE_DATA_DIR:-"${POCKETBASE_WORKDIR}/data"}"
export POCKETBASE_MIGRATION_DIR="${POCKETBASE_MIGRATION_DIR:-"${POCKETBASE_WORKDIR}/migrations"}"
export POCKETBASE_PUBLIC_DIR="${POCKETBASE_PUBLIC_DIR:-"${POCKETBASE_WORKDIR}/public"}"
export POCKETBASE_HOOK_DIR="${POCKETBASE_HOOK_DIR:-"${POCKETBASE_WORKDIR}/hooks"}"

# PocketBase Configuration
export POCKETBASE_PORT_NUMBER="${POCKETBASE_PORT_NUMBER:-8090}"
export POCKETBASE_OPTS="${POCKETBASE_OPTS:-}"