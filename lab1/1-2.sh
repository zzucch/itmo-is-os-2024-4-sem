#!/usr/bin/env bash

ans=""

while :; do
	ans+="$tmp"
	read -r tmp

	if [[ $tmp == q ]]; then
		break
	fi
done

echo "$ans"
