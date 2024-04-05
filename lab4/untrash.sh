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
		if [[ ! -d $(dirname "$untrash_path") ]]; then
			echo "the original directory no longer exists, untrashing to the" \
				"user home directory"

			ln "$trash_dir/$link_name" "$HOME/$(basename "$untrash_path")"
			rm "$trash_dir/$link_name"

			exit 0
		fi

		if ln "$trash_dir/$link_name" "$untrash_path" 2>/dev/null; then
			rm "$trash_dir/$link_name"
		else
			echo "failed to make a link, provide new path: "
			read -r new_path

			if ln "$trash_dir/$link_name" "$new_path" 2>/dev/null; then
				echo "invalid path"
				exit 1
			fi

			rm "$trash_dir/$link_name"
		fi
		;;
	esac
done
