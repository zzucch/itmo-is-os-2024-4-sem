#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") filename"
	exit 1
fi

filename=$1

trash_dir=~/.trash
trash_log=~/.trash.log

result=$(grep "^$filename:" "$trash_log" | cut -d ':' -f 2,3)
echo "result: $result"

IFS=$'\n' read -r -d '' -a files <<<"$result"

for line in "${files[@]}"; do
	IFS=: read -r untrash_path link_name <<<"$line"
	echo "untrash $untrash_path? (y/N): "
	read -r response

	case "$response" in
	[nN][oO] | [nN])
		continue
		;;
	*)
		ln "$trash_dir/$link_name" "$untrash_path"
		rm "$trash_dir/$link_name"
		;;
	esac
done
