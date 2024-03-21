#!/usr/bin/env bash
#
# sudo systemctl start atd
# echo "bash ./3-1.sh" | at now + 2 minutes &

report_filename="report"

(tail -F -n0 "$HOME/$report_filename") |
	while read -r line; do
		echo "$line"
	done
