#!/usr/bin/env bats

setup() {
	load setup.bats
}

@test "will convert unix timestamp to date" {
	run fromtimestamp "1567339994"

	[ "$status" -eq 0 ]
	[ "$output" == "2019-09-01 12:13:14 UTC" ]
}
