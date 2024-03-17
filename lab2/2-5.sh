#!/usr/bin/env bash

script_dir="$(dirname "$0")"
bash $script_dir/2-4.sh

prev_ppid=""
count=0
ppid_runtimes_sum=0

rm 2-5-output.txt
touch 2-5-output.txt

while IFS= read -r line; do
	current_ppid=$(echo "$line" | awk '{print $3}' | cut -d'=' -f2)
	current_avg_runtime=$(echo "$line" | awk '{print $5}' | cut -d'=' -f2)

	if [[ -z $prev_ppid ]]; then
		prev_ppid=$current_ppid
	fi

	if [[ $current_ppid -ne $prev_ppid ]]; then
		current_avg_children_runtime=$(awk "BEGIN {
      printf \"%.3f\", $ppid_runtimes_sum / $count
    }")

		echo "Average_Children_Runtime_of_ParentID=$prev_ppid" \
			"is $current_avg_children_runtime" >>2-5-output.txt

		prev_ppid=$current_ppid
		ppid_runtimes_sum=0
		count=0
	fi

	count=$((count + 1))
	ppid_runtimes_sum=$(
    awk "BEGIN {
      printf \"%.3f\", $ppid_runtimes_sum + $current_avg_runtime
    }"
	)

	echo $line >>2-5-output.txt
done <2-4-output.txt
