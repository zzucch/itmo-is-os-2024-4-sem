#!/usr/bin/env bash

backup_report="$HOME/backup-report"
current_date=$(date +%Y-%m-%d)
backup_dir="$HOME/Backup-$current_date"

existing_backup_dir=$(
	find "$HOME" -maxdepth 1 -type d -name 'Backup-*' -mtime -7 -printf '%f\n' |
		head -1
)

source_dir="$HOME/source"

if [ "$existing_backup_dir" = "" ]; then
	mkdir -p "$backup_dir"
	echo "created backup directory $backup_dir" >>"$backup_report"

	cp -R "$source_dir"/* "$backup_dir/"

	for file in "$backup_dir/"*; do
		echo "copied $file" >>"$backup_report"
	done
else
	echo "using backup directory $existing_backup_dir" >>"$backup_report"

	for file in "$source_dir"/*; do
		filename=$(basename "$file")
		backup_file="$backup_dir/$filename"

		if [ ! -f "$backup_file" ]; then
			cp -R "$file" "$backup_dir/"
			echo "copied $filename" >>"$backup_report"

			continue
		fi

		if [[ $(stat -c%s "$file") -ne $(stat -c%s "$backup_file") ]]; then
			name_part="${filename%.*}"

			extension_part="${filename##*.}"
			if [[ -z $extension_part ]]; then
				extension_part=""
			fi

			prev_backup_filename="${name_part}.$current_date.$extension_part"

			mv "$backup_file" "$prev_backup_filename"
			cp -R "$file" "$backup_dir/"

			echo "renamed $filename to $prev_backup_filename" \
				"and copied $filename" >>"$backup_report"
		fi
	done
fi
