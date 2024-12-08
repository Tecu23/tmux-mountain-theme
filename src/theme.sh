#!/usr/bin/env bash

# TODO: Add window number position logic
# TODO: Add option to override the window colors
# TODO: Add hex color support
# TODO: Update README will all these options

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

    icon_window_bell=$(get_tmux_option "@mountain_theme_bell_window_icon" "󰂞 ")
    icon_window_mark=$(get_tmux_option "@mountain_theme_mark_window_icon" "󰃀 ")
    icon_window_silent=$(get_tmux_option "@mountain_theme_silent_window_icon" "󰂛 ")
    icon_window_activity=$(get_tmux_option "@mountain_theme_activity_window_incon" "󰖲 ")
    icon_window_current=$(get_tmux_option "@mountain_theme_current_window_icon" "󰖯 ")
    icon_window_last=$(get_tmux_option "@mountain_theme_last_window_icon" "󰖰 ")

    active_window_title=$(get_tmux_option "@mountain_theme_active_window_title" "#W ")
    active_window_number=$(get_tmux_option "@mountain_theme_active_window_number" "#I")
    inactive_window_title=$(get_tmux_option "@mountain_theme_inactive_window_title" "#W ")
    inactive_window_number=$(get_tmux_option "@mountain_theme_active_window_number" "#I")

    window_left_separator=$(get_tmux_option "@mountain_theme_window_left_separator" '█')
    window_middle_separator=$(get_tmux_option "@mountain_theme_window_middle_separator" "█")
    window_right_separator=$(get_tmux_option "@mountain_theme_window_right_separator" '█ ')

    window_fill=$(get_tmux_option "@mountain_theme_window_fill" "number")
    window_status_enable=$(get_tmux_option "@mountain_theme_window_status_enable" "true")           # show window status options
    window_status_icon_enable=$(get_tmux_option "@mountain_theme_window_status_icon_enable" "true") # override the current window icons

    status_fill=$(get_tmux_option "@mountain_theme_status_fill" "icon")
    status_left_separator=$(get_tmux_option "@mountain_theme_status_left_separator" ' ')
    status_right_separator=$(get_tmux_option "@mountain_theme_status_right_separator" "")
    status_right_separator_inverse=$(get_tmux_option "@mountain_theme_right_separator_inverse" "true")

    IFS=',' read -a status_modules <<<$(get_tmux_option "@mountain_theme_status_modules" "datetime,application,user")

    tmux set-option -gq status-left-length "100"
    tmux set-option -gq status-right-length "100"

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
    tmux set-option -g status-left "$(generate_session_string "$session_icon" "$window_left_separator" "$window_right_separator" "$transparent" "${PALLETE[bright_red]}" "${PALLETE[bright_green]}" "${PALLETE[normal_black]}")"

    ### Create Active Window Pane
    tmux set-window-option -g window-status-current-format "$(generate_window "${active_window_number}" "${PALLETE[bright_cyan]}" "${PALLETE[normal_black]}" "${PALLETE[bright_cyan]}" "${active_window_title}" "${window_fill}")"

    ### Create Inactive Window Pane
    tmux set-window-option -g window-status-format "$(generate_window "${inactive_window_number}" "${PALLETE[bright_black]}" "${PALLETE[normal_black]}" "${PALLETE[normal_white]}" ${inactive_window_title} "${window_fill}")"

    ### Right side
    tmux set-option -g status-right ""

    for module in "${status_modules[@]}"; do
        if [ ! -f "${current_dir}/status/${module}.sh" ]; then
            # TODO: Update logic to handle user created statuses
            # if no module is available, then do nothing for now
            #
            # tmux set-option -ga status-right "${module}"
            echo "${module}"
        else

            status_script_path="${current_dir}/status/${module}.sh"

            # shellcheck source=src/status/user.sh
            . "$status_script_path"

            icon_var="status_${module}_icon"
            accent_color_var="status_${module}_accent_color"
            icon_color_var="status_${module}_icon_color"
            text_var="status_${module}_text"

            status_icon="${!icon_var}"
            accent_color="${PALLETE["${!accent_color_var}"]}"
            icon_color="${PALLETE["${!icon_color_var}"]}"
            status_text="${!text_var}"

            tmux set-option -ga status-right "$(generate_status_module "$module" "$status_icon" "${accent_color}" "$status_text")"
        fi
    done
    tmux set-window-option -g window-status-separator ''
}

# run main function
main
