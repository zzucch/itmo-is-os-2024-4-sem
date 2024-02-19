#!/usr/bin/env bash

touch full.log

prev=false

awk '{
if ($3 == "(WW)") {
  $3 = "Warning"
  prev = true

  print($0)
} else if (substr($3, 0, 1) != "(" && substr($3, 3, 1) && prev == true) {
  print($0)
} else {
  prev = false
}
}' /home/pc/Downloads/anaconda/syslog >full.log

awk '{
if ($3 == "(II)") {
  $3 = "Information"
  prev = true
  print($0)
} else if (substr($3,0,1) != "(" && substr($3,3,1) != ")" && prev == true){
  print($0)
} else {
  prev=false
}
}' /home/pc/Downloads/anaconda/syslog >full.log

cat full.log
