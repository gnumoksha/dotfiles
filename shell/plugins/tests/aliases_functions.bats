#!/usr/bin/env bats

setup() {
	# `sudo apt install bats-support bats-assert bats-file` or use the docker image
	load '/usr/lib/bats/bats-support/load'
	load '/usr/lib/bats/bats-assert/load'

	# get the containing directory of this file
	DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
	# add the ../bin directory to the PATH
	PATH="$DIR/../:$PATH"

	# loads the script under test
	load 10-aliases-functions.sh

	mkdir -p "$BATS_TMPDIR/a/b/c"
	touch "$BATS_TMPDIR/a/b/c/d.txt"
}

@test "will change to the file's directory" {
	run touch "$BATS_TMPDIR/a/b/b.txt" && cdf "$BATS_TMPDIR/a/b/b.txt"

	[ "$status" -eq 0 ]
	[ "$(pwd)" == "$BATS_TMPDIR/a/b" ]
}

@test "will not change to the directory of a non-existent file" {
	run cdf "$BATS_TMPDIR/foo/bar/baz.txt"

	[ "$status" -eq 1 ]
	[ "$output" == "$BATS_TMPDIR/foo/bar/baz.txt is not a file" ]
}

@test "will change to directory and show its content" {
	run cdls "$BATS_TMPDIR/a/b/c"

	[ "$status" -eq 0 ]
	[ "${lines[0]}" == "d.txt" ]
}
