#!/usr/bin/env bash

backup_dir=$(
	find "$HOME" -maxdepth 1 -type d -name 'Backup-*' -mtime -7 -printf '%f\n' |
		sort -r |
		head -1
)

destination_dir="$HOME/restore"
if [[ ! -d $destination_dir ]]; then
	mkdir "$destination_dir"
fi

regex=".*[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}.*"

find "$HOME/$backup_dir" -type f -regextype posix-extended ! -regex "$regex" \
	-exec cp {} "$destination_dir" \;
