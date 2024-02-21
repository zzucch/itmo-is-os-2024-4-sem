#!/usr/bin/env bash

awk '{
if ($2 == "INFO") {
  print $0
}
}' /home/pc/Downloads/anaconda/syslog >info.log
