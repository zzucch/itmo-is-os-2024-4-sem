#!/usr/bin/env bash

mem_pid=$(pgrep -f mem.sh)
if [[ -n $mem_pid ]]; then
	echo "killing mem.sh with PID $mem_pid.."
	kill "$mem_pid"
	wait "$mem_pid"
fi

monitor_pid=$(pgrep -f monitor.sh)
if [[ -n $monitor_pid ]]; then
	echo "killing monitor.sh with PID $monitor_pid.."
	kill "$monitor_pid"
	wait "$monitor_pid"
fi

echo "done"
