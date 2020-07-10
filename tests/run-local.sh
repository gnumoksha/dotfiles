#!/usr/bin/env bash

cd "$(dirname $BASH_SOURCE)/../"

echo "Running code analysis"
shellcheck shell/plugins/*.sh
echo

echo "Running unit tests"
bats shell/plugins/tests/
