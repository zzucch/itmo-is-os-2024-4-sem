#!/usr/bin/env bash

backup_dir=$(
	find "$HOME" -maxdepth 1 -type d -name 'Backup-*' -printf '%f\n' |
		sort -r |
		head -1
)

destination_dir="$HOME/restore"
regex="^[^.]+\\.[0-9]{4}-[0-9]{2}-[0-9]{2}(\\.[^.]+)?$"

find "$backup_dir" -type f -regextype posix-extended -regex ".$regex" \
	-exec cp {} "$destination_dir" \;
