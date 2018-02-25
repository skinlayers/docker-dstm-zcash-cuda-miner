#!/bin/bash
set -e

# if command starts with an option, prepend zm
if [ "${1:0:1}" = '-' ]; then
    set -- /usr/local/bin/zm "$@"
fi

exec "$@"
