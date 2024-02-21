#!/usr/bin/env bash

man bash \
  | tr -s '[:space:]' '\n' \
  | grep -E '\b\w{4,}\b' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -3
