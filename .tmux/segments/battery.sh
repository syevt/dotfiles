#!/bin/bash

runSegment() {
  # get battery level

  # this was for MacOS
  # battery=$(pmset -g batt | egrep "([0-9]+\%).*" -o | cut -f1 -d';')

  # check if on ac or battery power

  # this is for MacOS
  # if [[ $(pmset -g ps | head -1) =~ "AC Power" ]]; then
  # level=$(acpi | cut -d ' ' -f 4)

  # icon=""
  # percentage=$(acpi | cut -d ' ' -f 4):0:2
  # level=$((($percentage:0:2) + 0))

  # case $level in
  # [0-20])
    # icon=""
    # ;;
  # [21-40])
    # icon=""
    # ;;
  # [41-60])
    # icon=""
    # ;;
  # [61-80])
    # icon=""
    # ;;
  # *)
    # icon=""
    # ;;
  # esac

  # 

  if [[ $(acpi) =~ "charged" ]]; then
    # if on ac
    charging=$(acpi | cut -d ' ' -f 4-6 | sed 's/until/до повної/')
    # echo -n " ${level:0:2} ${charging}"
    echo -n " ${charging}"
  else
    # if on battery
    battery=$(acpi | cut -d ' ' -f 4-6 | sed 's/remaining/лишилося/')
    echo -n " ${battery}"
  fi
}
