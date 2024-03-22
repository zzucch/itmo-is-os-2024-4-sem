#!/usr/bin/env bash

calculate_infinitely() {
	while true; do
		echo $((2 * 2)) >>/dev/null
	done
}

calculate_infinitely &
calculate_infinitely &
calculate_infinitely &
