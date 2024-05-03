#!/bin/bash

if [[ -z $1 ]] || [[ -z $2 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N K"
	exit 1
fi

n=$1
k=$2

script_dir=$(dirname "$0")

for ((i = 1; i <= k; i++)); do
	echo "executing newmem, number $i.."
	bash "$script_dir"/newmem.sh "$n" &

	sleep 1
done
