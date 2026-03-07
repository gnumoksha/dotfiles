#!/usr/bin/env bats
# Tests the ../utils.sh script

setup() {
	# `sudo apt install bats-support bats-assert bats-file` or use the docker image
	load '/usr/lib/bats/bats-support/load'
	load '/usr/lib/bats/bats-assert/load'
	load '/usr/lib/bats/bats-file/load'

	# get the containing directory of this file
	DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
	# add the ../bin directory to the PATH
	PATH="$DIR/../:$PATH"

	# loads the script under test
	load utils.sh
}

@test "no output when sourcing the script" {
	. utils.sh
	[ "$output" = "" ]
}

@test "will not log debug messages if DOTFILES_BIN_DEBUG is not set to true" {
	run logger_debug "FooBarBaz"

	[ "$output" = "" ]
}

@test "will log debug messages when DOTFILES_BIN_DEBUG is set to true" {
	DOTFILES_BIN_DEBUG=true

	run logger_debug "FooBarBaz"

	assert_output --partial "debug"
	assert_output --partial "FooBarBaz"

	unset DOTFILES_BIN_DEBUG
}

@test "will log info messages" {
	run logger_info "FooBarBaz"

	assert_output --partial "info"
	assert_output --partial "FooBarBaz"
}

@test "will log error messages" {
	run logger_error "FooBarBaz"

	assert_output --partial "error"
	assert_output --partial "FooBarBaz"
}

@test "is running on Linux" {
	run assert_is_linux
	assert_success
}

@test "has cmd bats" {
	run has_cmd bats
	assert_success
}
