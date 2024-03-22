#!/usr/bin/env bash

name="3-4-calculations.sh"
cpu_usage_limit=10

first=$(pgrep -f "$name" | head -n 1)

if [[ -z $first || $first = 0 ]]; then
	echo "no processes found"
	exit 1
fi

current_niceness=$(ps -o ni -p "$first" | tail -n 1)

echo "$first : $current_niceness"

stopped=false

while true; do
	current_cpu_usage=$(ps -p "$first" -o %cpu --no-headers)
	current_cpu_usage=${current_cpu_usage%.*}

	sleeping_time=1

	echo "current cpu usage: $current_cpu_usage"

	if [[ $current_cpu_usage -gt $cpu_usage_limit ]]; then
		if [[ $current_niceness -eq 20 ]]; then
			if [[ $stopped = true ]]; then
				kill -CONT "$first"
				stopped=false
			else
				kill -STOP "$first"
				stopped=true

				sleeping_time=$((current_cpu_usage / 10))
				echo "stopping for $sleeping_time seconds"
			fi
		else
			renice -n $((current_niceness + 1)) -p "$first"
			current_niceness=$((current_niceness + 1))
		fi
	elif [[ $current_cpu_usage -lt $cpu_usage_limit ]]; then
		renice -n $((current_niceness - 1)) -p "$first"
		current_niceness=$((current_niceness - 1))
	fi

	sleep "$sleeping_time"
done
