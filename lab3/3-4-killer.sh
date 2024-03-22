#!/usr/bin/env bash

name="3-4-calculations.sh"
pids=()

while IFS= read -r pid; do
	pids+=("$pid")
done < <(pgrep -f "$name")

if [[ ${#pids[@]} -eq 0 ]]; then
	echo "No processes found with the name $name."
	exit 0
fi

for pid in "${pids[@]}"; do
	kill "$pid"
done

sleep 1
