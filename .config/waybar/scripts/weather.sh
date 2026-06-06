#!/usr/bin/env bash

# =============================================================================
# 13th version

LAT="48.4288"
LON="35.0181"
# LAT="48.0255" # Грізне
# LON="35.3511"

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
CACHE_FILE="$CACHE_DIR/weather.json"
CACHE_TTL=600

mkdir -p "$CACHE_DIR"

fetch_weather() {
  curl -sf \
    "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current_weather=true&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,precipitation_probability_mean,precipitation_hours,windspeed_10m_max,winddirection_10m_dominant&timezone=Europe/Kiev"
}

need_refresh=false

if [ ! -s "$CACHE_FILE" ]; then
  need_refresh=true
else
  now=$(date +%s)
  mtime=$(stat -c %Y "$CACHE_FILE")
  age=$((now - mtime))

  if [ "$age" -ge "$CACHE_TTL" ]; then
    need_refresh=true
  fi
fi

if $need_refresh; then
  if DATA=$(fetch_weather); then
    printf '%s\n' "$DATA" > "$CACHE_FILE"
  fi
fi

DATA=$(cat "$CACHE_FILE" 2>/dev/null)

# ---------- FETCH DATA ----------
# DATA=$(curl -sf "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current_weather=true&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,precipitation_probability_mean,precipitation_hours,windspeed_10m_max,winddirection_10m_dominant&timezone=Europe/Kiev")

if [ $? -ne 0 ] || [ -z "$DATA" ]; then
    jq -nrcM \
      --arg text " " \
      --arg tooltip "Weather service unavailable" \
      '{text:$text, tooltip:$tooltip}'
    exit 0
fi

# ---------- VALIDATE ----------
CURRENT_TEMP=$(jq -r '.current_weather.temperature // empty' <<< "$DATA")

if [ -z "$CURRENT_TEMP" ]; then
    jq -nrcM \
      --arg text " " \
      --arg tooltip "Weather API error" \
      '{text:$text, tooltip:$tooltip}'
    exit 0
fi

# ---------- ICONS ----------

weather_icon_day() {
    case "$1" in
        0) echo "" ;;
        1) echo "" ;;
        2) echo "" ;;
        3) echo "" ;;
        45|48) echo "" ;;
        51|53) echo "" ;;
        55) echo "" ;;
        56|57) echo "" ;;
        61) echo "" ;;
        63) echo "" ;;
        65) echo "" ;;
        66|67) echo "" ;;
        71|73) echo "" ;;
        75) echo "" ;;
        77) echo "" ;;
        80|81) echo "" ;;
        82) echo "" ;;
        85|86) echo "" ;;
        95|96|99) echo "" ;;
        *) echo "" ;;
    esac
}

weather_icon_night() {
    case "$1" in
        0) echo "" ;;
        1) echo "" ;;
        2) echo "" ;;
        3) echo "" ;;
        45|48) echo "" ;;
        51|53) echo "" ;;
        55) echo "" ;;
        56|57) echo "" ;;
        61) echo "" ;;
        63) echo "" ;;
        65) echo "" ;;
        66|67) echo "" ;;
        71|73) echo "" ;;
        75) echo "" ;;
        77) echo "" ;;
        80|81) echo "" ;;
        82) echo "" ;;
        85|86) echo "" ;;
        95|96|99) echo "" ;;
        *) echo "" ;;
    esac
}

# ---------- WIND ----------

wind_arrow() {
    deg=$1
    if   [ "$deg" -ge 337 ] || [ "$deg" -lt 23 ]; then echo "↑"
    elif [ "$deg" -lt 68 ];  then echo "↗"
    elif [ "$deg" -lt 113 ]; then echo "→"
    elif [ "$deg" -lt 158 ]; then echo "↘"
    elif [ "$deg" -lt 203 ]; then echo "↓"
    elif [ "$deg" -lt 248 ]; then echo "↙"
    elif [ "$deg" -lt 293 ]; then echo "←"
    else echo "↖"
    fi
}

# ---------- CURRENT ----------

read CURRENT_TEMP CURRENT_CODE IS_DAY <<< "$(
  jq -r '.current_weather | "\(.temperature) \(.weathercode) \(.is_day)"' <<< "$DATA"
)"

CURRENT_TEMP_ROUND=$(printf "%.0f" "$CURRENT_TEMP")

if [ "$IS_DAY" = "1" ]; then
    CURRENT_ICON=$(weather_icon_day "$CURRENT_CODE")
else
    CURRENT_ICON=$(weather_icon_night "$CURRENT_CODE")
fi

# ---------- DAILY ----------

readarray -t DAYS < <(jq -r '.daily.time[0:5][]' <<< "$DATA")
readarray -t TMAX < <(jq -r '.daily.temperature_2m_max[0:5][]' <<< "$DATA")
readarray -t TMIN < <(jq -r '.daily.temperature_2m_min[0:5][]' <<< "$DATA")
readarray -t WEATHER_CODES < <(jq -r '.daily.weathercode[0:5][]' <<< "$DATA")
readarray -t SUNRISE < <(jq -r '.daily.sunrise[0:5][]' <<< "$DATA")
readarray -t SUNSET < <(jq -r '.daily.sunset[0:5][]' <<< "$DATA")
readarray -t RAIN < <(jq -r '.daily.precipitation_sum[0:5][]' <<< "$DATA")
readarray -t POP < <(jq -r '.daily.precipitation_probability_mean[0:5][]' <<< "$DATA")
readarray -t RAIN_HOURS < <(jq -r '.daily.precipitation_hours[0:5][]' <<< "$DATA")
readarray -t WINDSPD < <(jq -r '.daily.windspeed_10m_max[0:5][]' <<< "$DATA")
readarray -t WINDDIR_RAW < <(jq -r '.daily.winddirection_10m_dominant[0:5][]' <<< "$DATA")

FIG=$'\u2007'
tooltip=""

for i in {0..4}; do

    dow=$(date -d "${DAYS[i]}" +%a)
    icon=" $(weather_icon_day "${WEATHER_CODES[i]}") "

    tmax=$(printf "%2.0f" "${TMAX[i]}")
    tmin=$(printf "%2.0f" "${TMIN[i]}")

    windspd=$(printf "%2.0f" "${WINDSPD[i]}")
    winddir=$(wind_arrow "${WINDDIR_RAW[i]}")

    sunrise_time=$(date -d "${SUNRISE[i]}" +%H:%M)
    sunset_time=$(date -d "${SUNSET[i]}" +%H:%M)

    # ---------- PRECIP FORMATTING (raw mm) ----------

    rain_val=${RAIN[i]}
    pop_val=${POP[i]}
    rain_h_val=${RAIN_HOURS[i]}

    # keep mm exactly as API gives it (trim only trailing zeros visually if any)
    rain=$(printf "%s" "$rain_val")

    pop=$(printf "%3.0f" "$pop_val")
    rain_h=$(printf "%2.0f" "$rain_h_val")

    # alignment for %
    pop=${pop// /$FIG}

    rain_str="$pop %  $rain mm / $rain_h h"

    # ---------- ALIGNMENT ----------

    printf -v tmax "%2s" "$tmax"; tmax=${tmax// /$FIG}
    printf -v tmin "%2s" "$tmin"; tmin=${tmin// /$FIG}
    printf -v windspd "%2s" "$windspd"; windspd=${windspd// /$FIG}
    printf -v rain_str "%12s" "$rain_str"; rain_str=${rain_str// /$FIG}

    line="$dow   $icon   $tmax  / $tmin °C  $rain_str    $winddir $windspd km/h   $sunrise_time   $sunset_time"

    if [ "$i" -eq 0 ]; then
        tooltip="$line"
    else
        tooltip="$tooltip"$'\n'"$line"
    fi
done

# ---------- TOOLTIP (ICON TABLE FOR DEBUGGING) --------------
# ---------- uncomment this instead of the forecast ----------
# ---------- to see all the icons mappings -------------------

# desc() {
#     case "$1" in
#         0) echo "clear sky" ;;
#         1) echo "mainly clear" ;;
#         2) echo "partly cloudy" ;;
#         3) echo "overcast" ;;
#         45) echo "fog" ;;
#         48) echo "rime fog" ;;
#         51) echo "light drizzle" ;;
#         53) echo "moderate drizzle" ;;
#         55) echo "dense drizzle" ;;
#         56) echo "freezing drizzle" ;;
#         57) echo "heavy freezing drizzle" ;;
#         61) echo "slight rain" ;;
#         63) echo "moderate rain" ;;
#         65) echo "heavy rain" ;;
#         66) echo "freezing rain" ;;
#         67) echo "heavy freezing rain" ;;
#         71) echo "slight snow" ;;
#         73) echo "moderate snow" ;;
#         75) echo "heavy snow" ;;
#         77) echo "snow grains" ;;
#         80) echo "rain showers" ;;
#         81) echo "moderate showers" ;;
#         82) echo "violent showers" ;;
#         85) echo "snow showers" ;;
#         86) echo "heavy snow showers" ;;
#         95) echo "thunderstorm" ;;
#         96) echo "storm + hail" ;;
#         99) echo "storm + heavy hail" ;;
#     esac
# }
#
# codes=(
# 0 1 2 3
# 45 48
# 51 53 55 56 57
# 61 63 65 66 67
# 71 73 75 77
# 80 81 82
# 85 86
# 95 96 99
# )
#
# tooltip="code  description              day  night"
#
# for c in "${codes[@]}"; do
#     printf -v line "%-4s  %-22s  %s    %s" \
#         "$c" \
#         "$(desc "$c")" \
#         "$(weather_icon_day "$c")" \
#         "$(weather_icon_night "$c")"
#
#     tooltip="$tooltip"$'\n'"$line"
# done

# ---------- OUTPUT ----------

jq -nrcM \
  --arg text "$CURRENT_ICON $CURRENT_TEMP_ROUND°" \
  --arg tooltip "$tooltip" \
  '{text:$text, tooltip:$tooltip}'
# =============================================================================
