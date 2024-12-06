#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_application_icon=$(get_tmux_option "@mountain_theme_status_application_icon" " ")
status_application_accent_color=$(get_tmux_option "@mountain_theme_status_application_accent_color" "normal_yellow")
status_application_icon_color=$(get_tmux_option "@mountain_theme_status_application_icon_color" "bright_yellow")
status_application_text=$(get_tmux_option "@mountain_theme_status_application_text" " #{pane_current_command}")

export status_application_icon status_application_accent_color status_application_icon_color status_application_text
