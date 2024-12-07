#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_datetime_icon=$(get_tmux_option "@mountain_theme_status_datetime_icon" "󰃰")
status_datetime_accent_color=$(get_tmux_option "@mountain_theme_status_datetime_accent_color" "normal_orange")
status_datetime_icon_color=$(get_tmux_option "@mountain_theme_status_datetime_icon_color" "bright_orange")
status_datetime_text=$(get_tmux_option "@mountain_theme_status_datetime_text" "%H:%M")

export status_datetime_icon status_datetime_accent_color status_datetime_icon_color status_datetime_text
