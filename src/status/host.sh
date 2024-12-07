#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_host_icon=$(get_tmux_option "@mountain_theme_status_host_icon" "󰒋")
status_host_accent_color=$(get_tmux_option "@mountain_theme_status_host_accent_color" "normal_magenta")
status_host_icon_color=$(get_tmux_option "@mountain_theme_status_host_icon_color" "bright_magenta")
status_host_text=$(get_tmux_option "@mountain_theme_status_host_text" "#H")

export status_host_icon status_host_accent_color status_host_icon_color status_host_text
