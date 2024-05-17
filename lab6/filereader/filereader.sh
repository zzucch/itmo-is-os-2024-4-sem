#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N"

	exit 1
fi

filename="file_$1.txt"

while read -r value; do
	new_value=$((value * 2))
	echo "$new_value" >>"trash.txt"
done <"$filename"
