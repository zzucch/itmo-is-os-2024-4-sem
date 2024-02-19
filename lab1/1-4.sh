#!/usr/bin/env bash

if [[ $PWD == "$HOME" ]]; then
	echo "$HOME"
	exit 0
fi

echo "error"
exit 1
