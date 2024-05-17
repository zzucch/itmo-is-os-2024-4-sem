#!/usr/bin/env bash

script_dir=$(dirname "$0")
script_path=$script_dir/factorial.sh
results_path=$script_dir/results/factorial_1.txt

for ((i = 1; i <= 20; i++)); do
	for ((j = 1; j <= 10; j++)); do
		time_result=$(time bash "$script_path" "$i")
		echo "time result $time_result"
	done
done
