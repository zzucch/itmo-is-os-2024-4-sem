#!/usr/bin/env bash

for pid in /proc/[0-9]+; do
  [ -d "$pid" ] || continue

  ppid=$(awk -F: '/PPid/ {print $2}' "$pid/status"

  sum_exec_runtime=$(awk -F: '/se.sum_exec_runtime/ {print $2}' "$pid/sched")
  nr_switches=$(awk -F: 'nr_switches {print $2}' "$pid/sched")

  ART=$(bc <<< "scale=3;$sum_exec_runtime/$nr_switches")
done
