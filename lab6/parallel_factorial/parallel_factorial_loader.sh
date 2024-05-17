#!/usr/bin/env bash

script_dir=$(dirname "$0")
script_path=$script_dir/parallel_factorial.sh
results_dir=$script_dir/results
results_path=$results_dir/parallel_factorial_1.txt

if [[ ! -d $results_dir ]]; then
	mkdir -p "$results_dir"
fi

for ((i = 1; i <= 20; i++)); do
	echo "i = $i"
	for ((j = 1; j <= 10; j++)); do
		/usr/bin/time -o tmp.txt -f "%e" bash "$script_path" "$i"
		tail -n 1 tmp.txt >>"$results_path"
	done
done

rm tmp.txt
