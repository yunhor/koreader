#!/usr/bin/env bash

CI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${CI_DIR}/common.sh"

travis_retry make fetchthirdparty
make all
travis_retry make testfront
luajit $(which luacheck) --no-color -q frontend | tee ./luacheck.out
test $(grep Total ./luacheck.out | awk '{print $2}') -le 63