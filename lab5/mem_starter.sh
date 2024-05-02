#!/usr/bin/env bash

script_dir=$(dirname "$0")

bash "$script_dir"/mem.sh &
mem_pid=$!

bash "$script_dir"/mem2.sh &
mem2_pid=$!

bash "$script_dir"/monitor.sh &
monitor_pid=$!

wait "$mem_pid" "$mem2_pid"

kill "$monitor_pid"
wait "$monitor_pid"
