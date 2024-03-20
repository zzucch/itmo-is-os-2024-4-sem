#!/usr/bin/env bash

dir_name="test"
report_filename="report"

mkdir ~/"$dir_name" &&
	echo "directory $HOME/$dir_name created successfully" >>~/"$report_filename" ||
	echo "directory $HOME/$dir_name alredy exists" >>~/"$report_filename" &&
	touch ~/"$dir_name/$(date --iso-8601=seconds)"

website="www.net_nikogo.ru"

ping "$website" ||
	echo "$(date --iso-8601=seconds) : failed to ping" >>~/report
