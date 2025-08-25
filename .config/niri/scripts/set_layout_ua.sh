#!/usr/bin/env bash

# echo ua > /tmp/current_layout
echo 🇺🇦 > /tmp/current_layout
niri msg action switch-layout 1
pkill -RTMIN+8 waybar
