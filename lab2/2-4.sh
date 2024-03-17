#!/usr/bin/env bash

for pid_path in /proc/[0-9]*/; do
	if [[ -d "$pid_path" ]]; then
		pid=${pid_path%/}
		pid=${pid##*/}

		ppid=$(awk -F: '/PPid/ {print $2}' "/proc/$pid/status" | tr -d '\t')

		sum_exec_runtime=$(awk -F: '/se.sum_exec_runtime/ {print $2}' "/proc/$pid/sched")

		nr_switches=$(awk -F: '/nr_switches/ {print $2}' "/proc/$pid/sched")

		average_runtime=$(awk "BEGIN {printf \"%.3f\", $sum_exec_runtime / $nr_switches}")

		echo "$pid:$ppid:$average_runtime"
	fi
done \
	| sort -t ':' -k2n \
	| awk -F ':' '{
			print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3
		}' >2-4-output.txt
