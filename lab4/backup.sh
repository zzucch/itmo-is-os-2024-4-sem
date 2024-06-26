#!/usr/bin/env bash

backup_report="$HOME/backup-report"
current_date=$(date +%Y-%m-%d)
backup_dir="$HOME/Backup-$current_date"

existing_backup_dir=$(
	find "$HOME" -maxdepth 1 -type d -name 'Backup-*' -mtime -7 -printf '%f\n' |
		head -1
)

source_dir="$HOME/source"

if [[ ! -d $source_dir ]]; then
  echo "error: source directory $source_dir does not exist"
  exit 1
fi

if [[ -z $existing_backup_dir ]]; then
	mkdir -p "$backup_dir"
	echo "created backup directory $backup_dir" >>"$backup_report"

	cp -R "$source_dir"/* "$backup_dir/"

	for file in "$backup_dir/"*; do
		echo "copied $file" >>"$backup_report"
	done
else
	echo "using backup directory $existing_backup_dir" >>"$backup_report"

	for file in "$source_dir"/*; do
		file_name=$(basename "$file")
		backup_file="$backup_dir/$file_name"

		if [[ ! -f $backup_file ]]; then
			cp -R "$file" "$backup_dir/"
			echo "copied $file_name" >>"$backup_report"

			continue
		fi

		if [[ $(stat -c%s "$file") -ne $(stat -c%s "$backup_file") ]]; then
			prev_backup_filename="$backup_file.$current_date"

			mv "$backup_file" "$prev_backup_filename"
			cp -R "$file" "$backup_dir/"

			echo "renamed $file_name to $prev_backup_filename" \
				"and copied $file_name" >>"$backup_report"
		fi
	done
fi
