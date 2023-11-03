#!/usr/bin/env bats

load test_helper

setup() {
  mkdir -p "$BATS_TMPDIR/a/b/c"
  touch "$BATS_TMPDIR/a/b/c/d.txt"
}

@test "will change to the file's directory" {
  run touch "$BATS_TMPDIR/a/b/b.txt" && cdf "$BATS_TMPDIR/a/b/b.txt"
  [ "$status" -eq 0 ]
  [ "$(pwd)" = "$BATS_TMPDIR/a/b" ]
}

@test "will not change to the directory of a non-existent file" {
  run cdf "$BATS_TMPDIR/foo/bar/baz.txt"
  [ "$status" -eq 1 ]
  [ "$output" = "$BATS_TMPDIR/foo/bar/baz.txt is not a file" ]
}

@test "will change to directory and show its content" {
  run cdls "$BATS_TMPDIR/a/b/c"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "d.txt" ]
}

@test "will convert date to unix timestamp" {
  run totimestamp "2019-09-01 12:13:14"
  [ "$status" -eq 0 ]
  [ "$output" = "1567339994" ]
}

@test "will convert unix timestamp to date" {
  run fromtimestamp "1567339994"
  [ "$status" -eq 0 ]
  [ "$output" = "2019-09-01 12:13:14 UTC" ]
}
