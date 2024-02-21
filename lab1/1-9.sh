#!/usr/bin/env bash

find /var/log/ -name "*.log" -exec cat {} + | wc -l
