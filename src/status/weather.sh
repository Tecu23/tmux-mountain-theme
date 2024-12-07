#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_weather_icon=$(get_tmux_option "@mountain_theme_status_weather_icon" "")
status_weather_accent_color=$(get_tmux_option "@mountain_theme_status_weather_accent_color" "normal_yellow")
status_weather_icon_color=$(get_tmux_option "@mountain_theme_status_weather_icon_color" "bright_yellow")
status_weather_text=$(get_tmux_option "@mountain_theme_status_weather_text" "#{weather}")

export status_weather_icon status_weather_accent_color status_weather_icon_color status_weather_text
