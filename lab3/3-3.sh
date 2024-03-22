#!/usr/bin/env bash

script_dir="$(dirname "$0")"

(
	crontab -l >/dev/null 2>/dev/null
	echo "*/5 * * * 5 $script_dir/3-1.sh"
) | crontab -
