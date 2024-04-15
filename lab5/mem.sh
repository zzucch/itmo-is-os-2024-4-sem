#!/usr/bin/env bash

script_dir=$(dirname "$0")
report_log_filename=$script_dir/report.log
offset=100000

true >"$report_log_filename"

array=()
step=0

while true; do
	for i in {1..10}; do
		array+=("$i")

		((step++))

		if ((step % offset == 0)); then
			echo ${#array[@]} >>"$report_log_filename"
		fi
	done
done
