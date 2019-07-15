#!/usr/bin/env bash

cd "$(dirname $BASH_SOURCE)/../"

echo "Running code analysis"
shellcheck cli/shell/plugins/*.sh
echo

echo "Running unit tests"
bats cli/shell/plugins/tests/
