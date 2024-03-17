#!/usr/bin/env bash

max_mem_kb=0
max_pid=0

for pid in $(ls /proc | grep -E '^[0-9]+$'); do
	if [[ ! -d "/proc/$pid" ]]; then
		continue
	fi

	mem_kb=$(awk -F: '/VmSize/ {print $2}' "/proc/$pid/status")

	if [[ -z $mem_kb ]]; then
		continue
	fi

	mem_kb=${mem_kb% *}
  mem_kb=$(echo $mem_kb | tr -d '\t')

	if [[ $mem_kb -gt $max_mem_kb ]]; then
		max_mem_kb=$mem_kb
		max_pid=$pid
	fi
done

echo "Process with max memory usage:" \
	"$(ps -p $max_pid -o comm=) ($max_pid)," \
	"memory usage: $max_mem_kb kB"
