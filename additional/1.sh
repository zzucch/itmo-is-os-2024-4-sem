#!/usr/bin/env bash

count=0

for arg in "$@"; do
	((count++))

	if ((count <= 10)); then
		echo "argument $count: $arg"
	fi
done
