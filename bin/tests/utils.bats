#!/usr/bin/env bats
# Tests the ../utils.sh script

setup() {
	# `sudo apt install bats-support bats-assert bats-file` or use the docker image
	load '/usr/lib/bats/bats-support/load'
	load '/usr/lib/bats/bats-assert/load'

	# get the containing directory of this file
	DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
	# add the ../bin directory to the PATH
	PATH="$DIR/../:$PATH"

	# loads the script under test
	load utils.sh
}

@test "no output when sourcing the script" {
	. utils.sh
	[ "$output" == "" ]
}

@test "will not log debug messages if DOTFILES_BIN_DEBUG is not set to true" {
	run logger_debug "Foo Bar Baz"

	[ "$output" == "" ]
}

@test "will log debug messages when DOTFILES_BIN_DEBUG is set to true" {
	# shellcheck disable=SC2034
	DOTFILES_BIN_DEBUG=true

	run logger_debug "Foo Bar Baz"

	assert_output --partial "debug"
	assert_output --partial "Foo Bar Baz"

	unset DOTFILES_BIN_DEBUG
}

@test "will log info messages" {
	run logger_info "Foo Bar Baz"

	assert_output --partial "info"
	assert_output --partial "Foo Bar Baz"
}

@test "will log error messages" {
	run logger_error "Foo Bar Baz"

	assert_output --partial "error"
	assert_output --partial "Foo Bar Baz"
}

@test "is running on Linux" {
	run assert_is_linux
	assert_success
}

@test "will get the linux distribution" {
	run --separate-stderr get_distribution

	refute_stderr
	[ "$output" != "" ]
}

@test "has cmd bats" {
	run has_cmd bats

	assert_success
}
