#!/usr/bin/env bash

script_dir="$(dirname "$0")"
pipe_name="$script_dir"/3-6-pid-pipe

echo $$ >"$pipe_name"

while read -r line; do
	case $line in
	"+")
		kill -SIGUSR1 "$(cat "$pipe_name")"
		;;
	"*")
		kill -SIGUSR2 "$(cat "$pipe_name")"
		;;
	*TERM*)
		kill -SIGTERM "$(cat "$pipe_name")"

		exit 0
		;;
	*) ;;
	esac
done
