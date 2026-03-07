#!/usr/bin/env bash

cd "$(dirname $BASH_SOURCE)/../"

echo "Running code analysis"
shellcheck shell/plugins/*.sh
echo

echo "Running unit tests for shell plugins"
bats shell/plugins/tests/

echo "Running unit tests for bin/"
bats bin/tests/
