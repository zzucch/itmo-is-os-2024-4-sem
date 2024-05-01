#!/usr/bin/env bash

script_dir=$(dirname "$0")
script_path=$script_dir/factorial.sh

for ((i = 1; i <= 20; i++)); do
	declare -a times

	for ((j = 1; j <= 10; j++)); do
		time_result=$(time bash "$script_path" "$i")
		time=$(echo "$time_result" | grep -oP 'real\s*\K\d+(\.\d+)')
		times+=("$time")
	done

	avg=$(echo "scale=3; (${times[*]}/${#times[@]})" | bc)

	echo "N = $i, Average time = $avg"
done
