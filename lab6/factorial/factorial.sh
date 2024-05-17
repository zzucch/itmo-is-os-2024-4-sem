#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
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

	echo "$result"
}

for ((i = 1; i <= n; i++)); do
	echo "factorial of $i is $(factorial "$i")"
done
