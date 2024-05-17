#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N"

	exit 1
fi

n=$1

factorial() {
	local n=$1
	local result=1

	for ((i = 1; i <= n; i++)); do
		result=$((result * i))
	done
}

for ((i = 1; i <= n; i++)); do
	factorial "$i"
done
