#!/usr/bin/env bash

array=("$1" "$2" "$3")
((max=array[1]))

for key in "${array[@]}"; do
	if [[ "$max" -lt "$key" ]]; then 
    max=$key
	fi
done

echo "$max"
