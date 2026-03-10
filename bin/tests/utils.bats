#!/usr/bin/env bats
# Tests the ../utils.sh script

setup() {
	load setup.bats

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
	if [[ "$GITHUB_ACTIONS" == "true" ]]; then
		# bats on GitHub Actions does not have refute_stderr
		return
	fi
	run --separate-stderr get_distribution

	refute_stderr
	[ "$output" != "" ]
}

@test "has cmd bats" {
	run has_cmd bats

	assert_success
}
