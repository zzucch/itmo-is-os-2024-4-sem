#!/usr/bin/env bash

for pid in $(ls /proc | grep -E '^[0-9]+$'); do
	if [[ ! -d "/proc/$pid" ]]; then
		continue
	fi

	ppid=$(awk -F: '/PPid/ {print $2}' "/proc/$pid/status" | tr -d '\t')

	sum_exec_runtime=$(
		awk -F: '/se.sum_exec_runtime/ {print $2}' "/proc/$pid/sched"
	)

	nr_switches=$(awk -F: '/nr_switches/ {print $2}' "/proc/$pid/sched")

	average_running_time=$(
		echo "{$sum_exec_runtime/$nr_switches}" | awk '{printf "%.3f", $1}'
	)

	echo "$pid:$ppid:$average_running_time"

done \
	| sort -t ':' -k2n \
	| awk -F ':' '{
    print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3
  }' >2-4-output.txt
