#!/usr/bin/env bash

if [ "$1" = "" ]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N"
	echo "N - max array size"

	exit 1
fi

N=$1

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

		if [[ ${#array[@]} -gt $N ]]; then
			echo "array size is more than $N, exiting.."

			exit 0
		fi

		if ((step % offset == 0)); then
			echo ${#array[@]} >>"$report_log_filename"
		fi
	done
done
