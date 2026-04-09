#!/usr/bin/env bash

# 10th version

LAT="48.4288"
LON="35.0181"

# ---------- FETCH DATA ----------
DATA=$(curl -sf "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current_weather=true&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,windspeed_10m_max,winddirection_10m_dominant&timezone=Europe/Kiev")

# curl failed OR returned nothing

if [ $? -ne 0 ] || [ -z "$DATA" ]; then
    jq -nrcM \
      --arg text " " \
      --arg tooltip "Weather service unavailable" \
      '{text:$text, tooltip:$tooltip}'
    exit 0
fi

# ---------- VALIDATE API RESPONSE ----------

CURRENT_TEMP=$(jq -r '.current_weather.temperature // empty' <<< "$DATA")

# If API response is malformed or missing fields
if [ -z "$CURRENT_TEMP" ]; then
    jq -nrcM \
      --arg text " " \
      --arg tooltip "Weather API error" \
      '{text:$text, tooltip:$tooltip}'
    exit 0
fi

# ---------- WEATHER ICONS ----------

weather_icon_day() {
    case "$1" in
        0) echo "" ;;           # clear
        1) echo "" ;;           # mainly clear
        2) echo "" ;;           # partly cloudy
        3) echo "" ;;           # cloudy

        45|48) echo "" ;;       # fog

        51|53) echo "" ;;       # light and moderate drizzle
        55) echo "" ;;          # dense drizzle
        56|57) echo "" ;;       # freezing drizzle

        61) echo "" ;;          # slight rain (using day hail here)
        63) echo "" ;;          # moderate rain
        65) echo "" ;;          # heavy rain
        66|67) echo "" ;;       # freezing rain

        71|73) echo "" ;;       # snow
        75) echo "" ;;          # snow
        77) echo "" ;;          # snow
        80|81) echo "" ;;       # rain showers
        82) echo "" ;;          # rain showers
        85|86) echo "" ;;       # snow showers

        95|96|99) echo "" ;;    # thunderstorm
        *) echo "" ;;
    esac
}

weather_icon_night() {
    case "$1" in
        0) echo "" ;;           # clear
        1) echo "" ;;           # mainly clear
        2) echo "" ;;           # partly cloudy
        3) echo "" ;;           # cloudy

        45|48) echo "" ;;

        51|53) echo "" ;;       # light and moderate drizzle
        55) echo "" ;;          # dense drizzle
        56|57) echo "" ;;       # freezing drizzle

        61) echo "" ;;          # slight rain (using night-alt hail here)
        63) echo "" ;;          # moderate rain
        65) echo "" ;;          # heavy rain
        66|67) echo "" ;;

        71|73) echo "" ;;       # snow
        75) echo "" ;;          # snow
        77) echo "" ;;          # snow
        80|81) echo "" ;;       # rain showers
        82) echo "" ;;          # rain showers
        85|86) echo "" ;;

        95|96|99) echo "" ;;    # thunderstorm
        *) echo "" ;;
    esac
}

# ---------- WIND DIRECTION ----------

wind_arrow() {
    deg=$1

    if   [ "$deg" -ge 337 ] || [ "$deg" -lt 23 ];  then echo "↑"
    elif [ "$deg" -lt 68 ];  then echo "↗"
    elif [ "$deg" -lt 113 ]; then echo "→"
    elif [ "$deg" -lt 158 ]; then echo "↘"
    elif [ "$deg" -lt 203 ]; then echo "↓"
    elif [ "$deg" -lt 248 ]; then echo "↙"
    elif [ "$deg" -lt 293 ]; then echo "←"
    else echo "↖"
    fi
}

# ---------- CURRENT CONDITIONS ----------

CURRENT_TEMP=$(jq -r '.current_weather.temperature' <<< "$DATA")
CURRENT_CODE=$(jq -r '.current_weather.weathercode' <<< "$DATA")
IS_DAY=$(jq -r '.current_weather.is_day' <<< "$DATA")

CURRENT_TEMP_ROUND=$(awk "BEGIN {printf \"%d\", $CURRENT_TEMP+0.5}")

if [ "$IS_DAY" = "1" ]; then
    CURRENT_ICON=$(weather_icon_day "$CURRENT_CODE")
else
    CURRENT_ICON=$(weather_icon_night "$CURRENT_CODE")
fi

# ---------- DAILY DATA ----------

readarray -t DAYS < <(jq -r '.daily.time[0:5][]' <<< "$DATA")
readarray -t TMAX < <(jq -r '.daily.temperature_2m_max[0:5][]' <<< "$DATA")
readarray -t TMIN < <(jq -r '.daily.temperature_2m_min[0:5][]' <<< "$DATA")
readarray -t WEATHER_CODES < <(jq -r '.daily.weathercode[0:5][]' <<< "$DATA")
readarray -t SUNRISE < <(jq -r '.daily.sunrise[0:5][]' <<< "$DATA")
readarray -t SUNSET < <(jq -r '.daily.sunset[0:5][]' <<< "$DATA")
readarray -t RAIN < <(jq -r '.daily.precipitation_sum[0:5][]' <<< "$DATA")
readarray -t WINDSPD < <(jq -r '.daily.windspeed_10m_max[0:5][]' <<< "$DATA")
readarray -t WINDDIR_RAW < <(jq -r '.daily.winddirection_10m_dominant[0:5][]' <<< "$DATA")

FIG=$'\u2007'
tooltip=""

for i in {0..4}; do

    dow=$(date -d "${DAYS[i]}" +%a)

    icon=" $(weather_icon_day "${WEATHER_CODES[i]}") "

    tmax=$(awk "BEGIN {printf \"%2d\", ${TMAX[i]}+0.5}")
    tmin=$(awk "BEGIN {printf \"%2d\", ${TMIN[i]}+0.5}")

    rain=$(awk "BEGIN {printf \"%.1f\", ${RAIN[i]} }")
    windspd=$(awk "BEGIN {printf \"%d\", ${WINDSPD[i]} }")

    winddir=$(wind_arrow "${WINDDIR_RAW[i]}")

    sunrise_time=$(date -d "${SUNRISE[i]}" +%H:%M)
    sunset_time=$(date -d "${SUNSET[i]}" +%H:%M)

    printf -v tmax "%2s" "$tmax"; tmax=${tmax// /$FIG}
    printf -v tmin "%2s" "$tmin"; tmin=${tmin// /$FIG}
    printf -v rain "%5s" "$rain"; rain=${rain// /$FIG}
    printf -v windspd "%2s" "$windspd"; windspd=${windspd// /$FIG}

    line="$dow   $icon   $tmax / $tmin °C  $rain mm  $winddir $windspd km/h   $sunrise_time   $sunset_time"

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
