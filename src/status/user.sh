#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

status_user_icon=$(get_tmux_option "@mountain_theme_status_user_icon" "")
status_user_accent_color=$(get_tmux_option "@mountain_theme_status_user_accent_color" "normal_blue")
status_user_icon_color=$(get_tmux_option "@mountain_theme_status_user_icon_color" "bright_blue")
status_user_text=$(get_tmux_option "@mountain_theme_status_user_text" "#(whoami)")

export status_user_icon status_user_accent_color status_user_icon_color status_user_text
