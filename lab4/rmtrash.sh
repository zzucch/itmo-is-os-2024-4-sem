#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
	echo "invalid arguments amount"
	echo "usage: $(basename "$0") filename"

	exit 1
fi

trash_dir=~/.trash
trash_log=~/.trash.log

if [[ ! -d $trash_dir ]]; then
	mkdir "$trash_dir"
fi

if [[ ! -f $1 ]]; then
	echo "file $1 does not exist"
	exit 1
fi

link_name=$(
	find "$trash_dir" -maxdepth 1 -type f |
		wc -l |
		awk '{print $1+1}'
)

if [[ -f $trash_dir/$link_name ]]; then
	echo "failed to create link file: file already exists"
	exit 1
fi

ln "$1" "$trash_dir/$link_name" && rm -i -- "$1"

echo "created hard link $trash_dir/$link_name" \
	"and removed $(realpath "$1")" >>"$trash_log"
