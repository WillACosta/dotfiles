#!/bin/bash
display=$1
input=$2
case $input in
  dp) val=15 ;;
  hdmi1) val=17 ;;
  hdmi2) val=18 ;;
  usbc) val=27 ;;
  *) echo "Unknown input: $input"; exit 1 ;;
esac
m1ddc display "$display" set input "$val"