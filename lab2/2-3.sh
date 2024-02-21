#!/usr/bin/env bash

ps -eo pid=,start_time --sort=start_time \
  | tail -n 1 \
  | awk '{print $1}'
