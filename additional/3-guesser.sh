#!/usr/bin/env bash

script_dir="$(dirname "$0")"

readonly guess_pipe_name="$script_dir"/guesses
readonly response_pipe_name="$script_dir"/responses
readonly regex='^[0-9]+ [0-9]+$'

if [[ ! -p $guess_pipe_name ]]; then
	mkfifo "$guess_pipe_name"
fi

readonly max_responses_count=2

current_response_count=0

while read -r guess; do
	echo "$guess" >>"$guess_pipe_name"
	(tail -F "$response_pipe_name") |
		while read -r line; do
			((current_response_count++))

			if [[ $line =~ $regex ]]; then
				read -r response_b response_c <<<"$line"
				echo "B: $response_b; C: $response_c"
			else
				echo "$line"
			fi

      if [[ $current_response_count -eq $max_responses_count ]]; then
        break
      fi
		done
done
