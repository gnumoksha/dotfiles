#!/usr/bin/env bats

setup() {
	load setup.bats
}

@test "will return the current unix timestamp" {
	run totimestamp "2019-09-01 12:13:14"

	[ "$status" -eq 0 ]
	[ "$output" != "" ]
}

@test "will convert date to unix timestamp" {
	run totimestamp "2019-09-01 12:13:14"

	[ "$status" -eq 0 ]
	[ "$output" == "1567339994" ]
}
