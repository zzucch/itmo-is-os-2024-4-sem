#!/usr/bin/env bash

script_dir="$(dirname "$0")"

pipe_name="$script_dir"/3-5-pipe

if [[ ! -p $pipe_name ]]; then
	mkfifo "$pipe_name"
fi

while read -r line; do
	echo "$line" >"$pipe_name"
done
