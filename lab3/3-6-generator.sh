#!/usr/bin/env bash

script_dir="$(dirname "$0")"
pid_filename="$script_dir"/3-6-pid

echo $$ >"$pid_filename"

while read -r line; do
	case $line in
	"+")
		kill -SIGUSR1 "$(cat "$pid_filename")"
		;;
	"*")
		kill -SIGUSR2 "$(cat "$pid_filename")"
		;;
	*TERM*)
		kill -SIGTERM "$(cat "$pid_filename")"

		exit 0
		;;
	*) ;;
	esac
done
