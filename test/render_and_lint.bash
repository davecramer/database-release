#!/bin/bash

set -e -u -o pipefail
set -o posix

_main() {
	local erb
	erb=$1

	local errno

	if "$(dirname "$0")"/render.rb "${erb}" | shellcheck --shell bash - ; then
		true
	else
		errno=$?
		return "${errno}"
	fi
}

_main "$@"
