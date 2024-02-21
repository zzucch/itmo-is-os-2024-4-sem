#!/usr/bin/env bash

rm -f info.log
touch info.log

awk '{
if ($2 == "INFO") {
  print $0
}
}' /home/pc/Downloads/anaconda/syslog >info.log
