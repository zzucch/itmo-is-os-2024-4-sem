#!/usr/bin/env bash

script_dir=$(dirname "$0")
script_path=$script_dir/filereader.sh
results_dir=$script_dir/results
results_path=$results_dir/filereader_1.txt

if [[ ! -d $results_dir ]]; then
	mkdir -p "$results_dir"
fi

for ((i = 1; i <= 20; i++)); do
	echo "i = $i"
	/usr/bin/time -o tmp.txt -f "%e" bash "$script_path" "$i"
	tail -n 1 tmp.txt >>"$results_path"
done
