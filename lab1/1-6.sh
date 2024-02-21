#!/usr/bin/env bash

rm -f full.log
touch full.log

prev=false

awk '{
if ($3 == "(WW)") {
  $3 = "Warning:"
  prev = true

  print($0)
} else if (substr($3, 0, 1) != "(" && substr($3, 3, 1) && prev == true) {
  print($0)
} else {
  prev = false
}
}' /home/pc/Downloads/anaconda/X.log >full.log

awk '{
if ($3 == "(II)") {
  $3 = "Information:"
  prev = true
  print($0)
} else if (substr($3,0,1) != "(" && substr($3,3,1) != ")" && prev == true){
  print($0)
} else {
  prev=false
}
}' /home/pc/Downloads/anaconda/X.log >full.log

cat full.log
