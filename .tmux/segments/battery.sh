#!/usr/bin/env bash

runSegment() {
  # get battery level
  charging=""
  icon=""
  left=""

  # this is for MacOS
  # charging=""
  # if [[ $(pmset -g ps | head -1) =~ "AC Power" ]]
  # then
    # charging=""
  # fi
  # level=$(acpi | cut -d ' ' -f 4)
  # battery=$(pmset -g batt | egrep "([0-9]+\%).*" -o | cut -f1 -d';')

  # percentage=$(acpi | cut -d ' ' -f 4):0:2
  # level=$((($battery:0:2) + 0))

  # this for linux
  # if [[ $(acpi -a) =~ "on-line" ]]
  # then
  #   charging=""
  #   left=$(acpi | head -n 1 | cut -d ' ' -f 5)
  # fi
  # battery=$(acpi -b | head -n 1 | egrep -o "[0-9]+%")

 read -r capacity < /sys/class/power_supply/BAT0/capacity
 read -r ac_online < /sys/class/power_supply/AC/online level=${battery%?} # removing last char '%'

 if [[ $ac_online -eq 1 ]]; then
   charging=""
   left="${capacity}%"
 fi

battery="${capacity}%"
level=$capacity

  # case $level in
  if ((0<=level && level<=20))
  then
    icon=""
  elif ((21<=level && level<=40))
  then
    icon=""
  elif ((41<=level && level<=60))
  then
    icon=""
  elif ((61<=level && level<=80))
  then
    icon=""
  else
    icon=""
  fi
  echo -n "${charging} ${icon} ${level}% ${left}"
}
