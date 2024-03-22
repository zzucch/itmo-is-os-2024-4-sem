#!/usr/bin/env bash

script_dir="$(dirname "$0")"

while read -r line; do
	echo "$line" >"$script_dir"/pipe
done
