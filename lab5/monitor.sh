#!/usr/bin/env bash

script_dir=$(dirname "$0")
monitor_log_filename=$script_dir/monitor.log

true >"$monitor_log_filename"

while true; do
	echo -e "\n$(date)\n" | tee -a "$monitor_log_filename"

	top -b -n 1 -c |
		head -n 13 |
		tee -a "$monitor_log_filename"

	sleep 1
done
