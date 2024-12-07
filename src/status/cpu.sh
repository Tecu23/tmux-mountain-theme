#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_cpu_icon=$(get_tmux_option "@mountain_theme_status_cpu_icon" "")
status_cpu_accent_color=$(get_tmux_option "@mountain_theme_status_cpu_accent_color" "normal_magenta")
status_cpu_icon_color=$(get_tmux_option "@mountain_theme_status_cpu_icon_color" "bright_magenta")
status_cpu_text=$(get_tmux_option "@mountain_theme_status_cpu_text" "#{cpu_percentage}")

export status_cpu_icon status_cpu_accent_color status_cpu_icon_color status_cpu_text
