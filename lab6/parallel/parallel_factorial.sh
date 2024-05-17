#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") N"

	exit 1
fi

n=$((1000 + "$1"))

factorial() {
	local _n=$1
	local _result=1

	for ((_i = 1; _i <= _n; _i++)); do
		result=$((result * _i))
	done
}

export -f factorial

seq "$n" | parallel -j0 factorial
