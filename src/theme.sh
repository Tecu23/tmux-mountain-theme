#!/usr/bin/env bash

# TODO: Make transparent background setting work
# TODO: Add reverse icon logic

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

    border_style_active_pane=$(get_tmux_option "@mountain_theme_active_pane_border_style" "${PALLETE[normal_black]}")
    border_style_inactive_pane=$(get_tmux_option "@mountain_theme_inactive_pane_border_style" "${PALLETE[bright_black]}")

    session_icon=$(get_tmux_option "@mountain_theme_session_icon" "")
    active_window_icon=$(get_tmux_option "@mountain_theme_plugin_active_window_icon" " ")
    inactive_window_icon=$(get_tmux_option "@mountain_theme_plugin_inactive_window_icon" " ")
    zoomed_window_icon=$(get_tmux_option "@mountain_theme_plugin_zoomed_window_icon" " ")
    pane_synchronized_icon=$(get_tmux_option "@mountain_theme_plugin_pane_synchronized_icon" "✵")

    active_window_title=$(get_tmux_option "@mountain_theme_active_window_title" "#W ")
    inactive_window_title=$(get_tmux_option "@mountain_theme_inactive_window_title" "#W ")

    left_separator=$(get_tmux_option "@mountain_theme_left_separator" ' ')    # '' ""
    middle_separator=$(get_tmux_option "@mountain_theme_middle_separator" '█') #
    right_separator=$(get_tmux_option "@mountain_theme_right_separator" "")   # ''thee

    IFS=',' read -ra status_options <<<"$(get_tmux_option "@mountain_theme_status_options", "datetime,application,user")"

    if [ "$transparent" = "true" ]; then
        right_separator_inverse=$(get_tmux_option "@mountain_theme_transparent_right_separator_inverse" " ") # ''
    fi

    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100

    # messages
    tmux set-option -gq message-style "fg=${PALLETE[fg]},bg=default,align=centre"
    tmux set-option -gq message-command-style "fg=${PALLETE[fg]},bg=default,align=centre"

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
    tmux set-option -g status-left "$(generate_session_string "$session_icon" "$left_separator" "$right_separator" "$transparent" "${PALLETE[bright_red]}" "${PALLETE[bright_green]}" "${PALLETE[normal_black]}")"

    ### Create Active Window Pane
    tmux set-window-option -g window-status-current-format "$(generate_window_string "$active_window_icon" "$zoomed_window_icon" "$pane_synchronized_icon" "$left_separator" "$middle_separator" "$right_separator" "$transparent" "$active_window_title" "${PALLETE[bright_cyan]}" "${PALLETE[normal_cyan]}" "${PALLETE[normal_black]}" "${PALLETE[bg]}")"

    ### Create Inactive Window Pane
    tmux set-window-option -g window-status-format "$(generate_window_string "$inactive_window_icon" "$zoomed_window_icon" "$pane_synchronized_icon" "$left_separator" "$middle_separator" "$right_separator" "$transparent" "$inactive_window_title" "${PALLETE[bright_black]}" "${PALLETE[bright_white]}" "${PALLETE[normal_black]}" "${PALLETE[bg]}")"

    ### Right side
    tmux set-option -g status-right ""

    for option in "${status_options[@]}"; do

        if [ ! -f "${current_dir}/status/${option}.sh" ]; then
            # TODO: Update logic to handle user created statuses
            # if no option is available, then do nothing for now
            #
            # tmux set-option -ga status-right "${option}"
            echo "${option}"
        else

            status_script_path="${current_dir}/status/${option}.sh"

            # shellcheck source=src/status/user.sh
            . "$status_script_path"

            icon_var="status_${option}_icon"
            accent_color_var="status_${option}_accent_color"
            icon_color_var="status_${option}_icon_color"
            text_var="status_${option}_text"

            status_icon="${!icon_var}"
            accent_color="${PALLETE["${!accent_color_var}"]}"
            icon_color="${PALLETE["${!icon_color_var}"]}"
            status_text="${!text_var}"

            tmux set-option -ga status-right "$(generate_module_string "$status_icon" "$status_text" "$accent_color" "$icon_color" "$left_separator" "$middle_separator" "$right_separator" "${PALLETE[normal_black]}")"
        fi
    done
    tmux set-window-option -g window-status-separator ''
}

# run main function
main
