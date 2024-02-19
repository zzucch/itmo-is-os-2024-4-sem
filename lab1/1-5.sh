#!/usr/bin/env bash

touch info.log

awk '{
if ($2 == "INFO") {
  print $0
}
}' /home/pc/Downloads/anaconda/syslog >info.log
