#!/usr/bin/env bash

process_count="$(ps -U "$USER" | wc -l)"

echo "User $USER has $process_count processes." >2-1-output.txt

processes="$(ps -U "$USER" -o pid=,command=)"
while IFS=' ' read -r pid command; do
	echo "$pid:$command" >>2-1-output.txt
done < <(echo "$processes")
