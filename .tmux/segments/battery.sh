#!/bin/bash

runSegment() {
  # get battery level

  # this was for MacOS
  battery=$(pmset -g batt | egrep "([0-9]+\%).*" -o | cut -f1 -d';')
  level=${battery%?} # removing last char '%'

  # check if on ac or battery power
  # this is for MacOS
  charging=""
  if [[ $(pmset -g ps | head -1) =~ "AC Power" ]]
  then
    charging=""
  fi
  # level=$(acpi | cut -d ' ' -f 4)
  # battery=$(pmset -g batt | egrep "([0-9]+\%).*" -o | cut -f1 -d';')

  icon=""
  # percentage=$(acpi | cut -d ' ' -f 4):0:2
  # level=$((($battery:0:2) + 0))

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
  echo -n "${charging} ${icon} ${level}%"

  # 

  # this for linux
  # if [[ $(acpi) =~ "charged" ]]; then
    # # if on ac
    # charging=$(acpi | cut -d ' ' -f 4-6 | sed 's/until/до повної/')
    # # echo -n " ${level:0:2} ${charging}"
    # echo -n " ${charging}"
  # else
    # # if on battery
    # battery=$(acpi | cut -d ' ' -f 4-6 | sed 's/remaining/лишилося/')
    # echo -n " ${battery}"
  # fi
}
