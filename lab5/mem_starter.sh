#!/usr/bin/env bash

script_dir=$(dirname "$0")

bash "$script_dir"/mem.sh &
bash "$script_dir"/mem2.sh &

bash "$script_dir"/monitor.sh &

wait
