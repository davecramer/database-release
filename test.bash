#!/bin/bash

set -e -u -o pipefail
set -o posix

_main() {
	shell_scripts | xargs shellcheck --shell bash
	erb_shell_scripts | xargs -n1 -t test/render_and_lint.bash
}

shell_scripts() {
	find test -name '*.bash'
	find packages -name 'packaging' -or -name 'pre_packaging'
}

erb_shell_scripts() {
	find jobs -name '*.bash' -or -name '*.bash.erb'
}

_main "$@"
