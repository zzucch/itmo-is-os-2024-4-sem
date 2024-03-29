#!/usr/bin/env bash

script_dir="$(dirname "$0")"
pid_filename="$script_dir"/3-6-pid

echo $$ >"$pid_filename"

current_value=1

usr1() {
	current_value=$((current_value + 2))
	echo "current value: $current_value"
}

usr2() {
	current_value=$((current_value * 2))
	echo "current value: $current_value"
}

sigterm() {
	echo "got SIGTERM, exiting"

	exit 0
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true; do
	sleep 1
done
