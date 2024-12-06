#!/usr/bin/env bash

# setting the locale, some users have issues with different locales, this enforces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=src/utils.sh
source "$current_dir/utils.sh"

main() {
    theme_variation=$(get_tmux_option "@mountain_theme_variation" "fuji")

    # shellcheck source=src/palletes/fuji.sh
    . "$current_dir/palletes/$theme_variation.sh"

    ### Load Options
    transparent=$(get_tmux_option "@mountain_theme_transparent_bg" "true")

    border_style_active_pane=$(get_tmux_option "@theme_active_pane_border_style" "${PALLETE[bg]}")
    border_style_inactive_pane=$(get_tmux_option "@theme_inactive_pane_border_style" "${PALLETE[bg]}")

    session_icon=$(get_tmux_option "@theme_session_icon" "")
    active_window_icon=$(get_tmux_option "@theme_plugin_active_window_icon" " ")
    inactive_window_icon=$(get_tmux_option "@theme_plugin_inactive_window_icon" " ")
    zoomed_window_icon=$(get_tmux_option "@theme_plugin_zoomed_window_icon" " ")
    pane_synchronized_icon=$(get_tmux_option "@theme_plugin_pane_synchronized_icon" "✵")

    active_window_title=$(get_tmux_option "@theme_active_window_title" "#W ")
    inactive_window_title=$(get_tmux_option "@theme_inactive_window_title" "#W ")

    left_separator=$(get_tmux_option "@theme_left_separator" '')
    right_separator=$(get_tmux_option "@theme_right_separator" '')

    if [ "$transparent" = "true" ]; then
        right_separator_inverse=$(get_tmux_option "@theme_transparent_right_separator_inverse", '')
    fi

    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100

    ### status bar
    status_bar_bg=${PALLETE[bg]}
    if [ "$transparent" = "true" ]; then
        status_bar_bg="default"
    fi
    tmux set-option -g status-style "bg=${status_bar_bg},fg=${PALLETE[bright_black]}"

    ### Border Color
    tmux set-option -g pane-active-border-style "fg=$border_style_active_pane"
    tmux set-option -g pane-border-style "#{?pane_synchronized,fg=$border_style_active_pane,fg=$border_style_inactive_pane}"

    ### Create Session String
    tmux set-option -g status-left "$(generate_session_string "$session_icon" "$left_separator" "$transparent" "${PALLETE[bright_red]}" "${PALLETE[bright_green]}")"

    ### Create Active Window Pane
    tmux set-window-option -g window-status-current-format "$(generate_window_string "$active_window_icon" "$zoomed_window_icon" "$pane_synchronized_icon" "$left_separator" "$transparent" "$active_window_title" "${PALLETE[bright_cyan]}" "${PALLETE[normal_cyan]}" "${PALLETE[normal_black]}" "${PALLETE[bg]}")"

    ### Create Inactive Window Pane
    tmux set-window-option -g window-status-format "$(generate_window_string "$inactive_window_icon" "$zoomed_window_icon" "$pane_synchronized_icon" "$left_separator" "$transparent" "$inactive_window_title" "${PALLETE[bright_black]}" "${PALLETE[normal_black]}" "${PALLETE[fg]}" "${PALLETE[bg]}")"

    ### Right side
    tmux set-option -g status-right ""
}

# run main function
main
