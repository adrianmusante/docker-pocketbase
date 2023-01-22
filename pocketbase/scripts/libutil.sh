#!/bin/sh

is_boolean_yes() {
    grep -i -qE '^(1|true|yes)$' <(echo -n "${1-}")
}