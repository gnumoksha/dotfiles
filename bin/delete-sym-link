#!/bin/bash
# Deletes all symbolic links to files

if [[ -z "$1" ]]; then
    echo "Usage: $0 path"
    exit 1
fi

# https://stackoverflow.com/questions/22097130/delete-all-broken-symbolic-links-with-a-line
find -L "$1" -name . -o -type f -prune -o -type l -exec rm {} +

