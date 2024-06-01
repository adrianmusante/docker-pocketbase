#!/bin/sh

is_boolean_yes() {
    grep -i -qE '^(1|true|yes)$' <(echo -n "${1-}")
}

# Gets secret by strategy:
# - ENVIRONMENT_VARIABLE
# - KEY as filename at /var/run/secrets.
# - KEY with suffix _FILE to retrieve path in format absolute or relative to /var/run/secrets
get_secret() {
  local key="${1:-}"
  _v() { eval "echo \${$1:-}" ;}
  _cat() { cat "$1" 2>/dev/null || true ;}
  local value
  value="$(_v "$key")"
  if [ -z "$value" ]; then
    value="$(_cat "/var/run/secrets/$key")"
    if [ -z "$value" ]; then
      local path="$(_v "${key}_FILE")"
      if grep -vq '/' <(echo "$path"); then
        path="/var/run/secrets/$path"
      fi
      value="$(_cat "$path")"
    fi
  fi
  echo "$value"
}
