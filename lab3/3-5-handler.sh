#!/usr/bin/env bash

mode="addition"
current_value=1

script_dir="$(dirname "$0")"
pipe_name="$script_dir"/3-5-pipe

(tail -F "$pipe_name") |
	while read -r line; do
		if [[ $line == "+" ]]; then
			echo "in addition mode"
			mode="addition"
		elif [[ $line == "*" ]]; then
			echo "in multiplication mode"
			mode="multiplication"
		elif [[ $line =~ ^[0-9]+$ ]]; then
			if [[ $mode == "addition" ]]; then
				current_value=$((current_value + line))
			elif [[ $mode == "multiplication" ]]; then
				current_value=$((current_value * line))
			fi
		elif [[ $line == "QUIT" ]]; then
			echo "scheduled shutdown"
			pkill -f script5Generator

			break
		else
			echo "error: incorrect input $line"
			pkill -f script5Generator

			break
		fi
	done
