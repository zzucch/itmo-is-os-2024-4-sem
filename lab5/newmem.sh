#!/usr/bin/env bash

if [ "$1" = "" ]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N"
	echo "N - max array size"

	exit 1
fi

max_array_size=$1

offset=100000

array=()
step=0

while true; do
	for i in {1..10}; do
		array+=("$i")

		((step++))

		if [[ ${#array[@]} -gt $max_array_size ]]; then
			echo "array size is more than $max_array_size, exiting.."

			exit 0
		fi

		if ((step % offset == 0)); then
			echo ${#array[@]}
		fi
	done
done
