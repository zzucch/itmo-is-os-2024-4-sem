#!/usr/bin/env bash

awk -F':' '{print $3, $1}' /etc/passwd | sort -t : -n -k1
