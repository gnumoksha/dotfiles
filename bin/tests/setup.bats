#!/usr/bin/env bats

# `sudo apt install bats-support bats-assert bats-file` or use the docker image
load '/usr/lib/bats/bats-support/load'
load '/usr/lib/bats/bats-assert/load'
load '/usr/lib/bats/bats-file/load'

# get the containing directory of this file
DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
# add the ../bin directory to the PATH
PATH="$DIR/../:$PATH"
