echo 🏴󠁧󠁢󠁥󠁮󠁧󠁿 > /tmp/current_layout
niri msg action switch-layout 0
pkill -RTMIN+8 waybar
pidof hyprlock || hyprlock
