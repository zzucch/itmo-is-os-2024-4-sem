#!/usr/bin/env bash

name="3-4-calculations.sh"
cpu_usage_limit=10

third=$(pgrep -f "$name" | tail -n 1)
current_niceness=$(ps -o ni -p "$third" | tail -n 1)

echo "$third : $current_niceness"

stopped=false

while true; do
	current_cpu_usage=$(ps -p "$third" -o %cpu --no-headers)
	current_cpu_usage=${current_cpu_usage%.*}

	sleeping_time=1

	echo "current cpu usage: $current_cpu_usage"

	if [[ $current_cpu_usage -gt $cpu_usage_limit ]]; then
		if [[ $current_niceness -eq 20 ]]; then
			if [[ $stopped = true ]]; then
				kill -CONT "$third"
				stopped=false
			else
				kill -STOP "$third"
				stopped=true

				sleeping_time=$((current_cpu_usage / 10))
				echo "stopping for $sleeping_time"
			fi
		else
			renice -n $((current_niceness + 1)) -p "$third"
			current_niceness=$((current_niceness + 1))
		fi
	elif [[ $current_cpu_usage -lt $cpu_usage_limit ]]; then
		renice -n $((current_niceness - 1)) -p "$third"
		current_niceness=$((current_niceness - 1))
	fi

	sleep "$sleeping_time"
done
