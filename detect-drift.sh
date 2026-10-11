#!/usr/bin/env bash
#shellcheck disable=SC2312
set -euo pipefail
TAILSCALE_API_KEY="${TAILSCALE_API_KEY:?Please supply a TAILSCALE_API_KEY}"
TAILSCALE_TAILNET="${TAILSCALE_TAILNET:?Please supply a TAILSCALE_TAILNET}"
tscli() {
	go run github.com/jaxxstorm/tscli/cmd/tscli@latest "${@}"
}
get_policy() {
	tscli get policy
}
get_policy > policy.hujson
truncate -s -1 policy.hujson # remove the spurious extra newline

git diff --exit-code 1>&2
