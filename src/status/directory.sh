#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_directory_icon=$(get_tmux_option "@mountain_theme_status_directory_icon" " ")
status_directory_accent_color=$(get_tmux_option "@mountain_theme_status_directory_accent_color" "normal_orange")
status_directory_icon_color=$(get_tmux_option "@mountain_theme_status_directory_icon_color" "bright_orange")
status_directory_text=$(get_tmux_option "@mountain_theme_status_directory_text" "#{b:pane_current_path}")

export status_directory_icon status_directory_accent_color status_directory_icon_color status_directory_text
