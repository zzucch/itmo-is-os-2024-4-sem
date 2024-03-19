#!/usr/bin/env bash

declare -a initial_read_bytes_array

for pid in /proc/[0-9]*/; do
	if [[ ! -d $pid ]]; then
		continue
	fi

	pid=${pid::-1}
	current_read_bytes=$(awk -F: '/read_bytes/ {print $2}' "$pid/io")

	pid=${pid##*/}
	initial_read_bytes_array["$pid"]=$current_read_bytes
done

sleep 60

declare -a read_bytes_deltas

for pid in /proc/[0-9]*/; do
	if [[ ! -d $pid ]]; then
		continue
	fi

	pid=${pid::-1}
	current_read_bytes=$(awk -F: '/read_bytes/ {print $2}' "$pid/io")

	pid=${pid##*/}
	initial_read_bytes=${initial_read_bytes_array[$pid]}
	read_bytes_deltas["$pid"]=$((current_read_bytes - initial_read_bytes))
done

declare -a pids_and_read_bytes_deltas

for key in "${!read_bytes_deltas[@]}"; do
	if [[ ${read_bytes_deltas["$key"]} -gt 0 ]]; then
		pids_and_read_bytes_deltas+=("$key ${read_bytes_deltas[$key]}")
	fi
done

if [[ ${#pids_and_read_bytes_deltas[@]} -eq 0 ]]; then
	echo "there are no processes that did io"

	exit 0
fi

declare -a sorted_read_bytes_deltas

IFS=$'\n'
sorted_read_bytes_deltas=(
	"$(sort -t' ' -k2,2 -rn <<<"${pids_and_read_bytes_deltas[*]}")")
unset IFS

processes_to_display=3
if [[ ${#sorted_read_bytes_deltas[@]} -lt $processes_to_display ]]; then
	echo "there are less than $processes_to_display processes that did io"

	processes_to_display=${#sorted_read_bytes_deltas[@]}
	echo "displaying $processes_to_display:"
fi

count=0

for item in "${sorted_read_bytes_deltas[@]}"; do
	if [[ $count -eq $processes_to_display ]]; then
		break
	fi

	((count++))

	pid=$(echo "$item" | awk '{print $1}')
	current_read_bytes_delta=$(echo "$item" | awk '{print $2}')

	cmdline=""
	if [[ -f /proc/$pid/cmdline ]]; then
		cmdline=$(tr -d '\0' <"/proc/$pid/cmdline")
	fi

	echo "pid=$pid : cmdline=$cmdline : read_bytes=$current_read_bytes_delta"
done
