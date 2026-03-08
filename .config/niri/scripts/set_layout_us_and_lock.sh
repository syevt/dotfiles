echo 🏴󠁧󠁢󠁥󠁮󠁧󠁿 > /tmp/current_layout
niri msg action switch-layout 0
pkill -RTMIN+8 waybar
if ! pidof hyprlock >/dev/null; then
    hyprlock &
fi
# pidof hyprlock || hyprlock
