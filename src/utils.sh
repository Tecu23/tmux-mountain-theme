#!/usr/bin/env bash

get_tmux_option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
        if [ "$value" = "null" ]; then
            echo ""
        else
            echo "$value"
        fi
    else
        echo "$default"
    fi
}

# Function: generate_session_string()
# Description:
#   creates the session string for the tmux status bar
#
# Parameters:
#   $1 (string) - the session icon
#   $2 (string) - the left separator
#   $3 (string) - the right separator
#   $4 (string) - whether the background is transparent or not
#   $5 (string) - background color for client prefix
#   $6 (string) - default background color
#   $7 (string) - foreground color
#
# Output:
#   - return: the session string
generate_session_string() {
    local session_icon="$1"
    local left_separator="$2"
    local right_separator="$3"
    local transparent="$4"

    separator_start="#[bg=default]#{?client_prefix,#[fg=$5],#[fg=$6]}${window_left_separator:?}"
    text="#{?client_prefix,#[bg=$5],#[bg=$6]}#[fg=$7,bold]${session_icon} #S"
    separator_end="#[bg=default]#{?client_prefix,#[fg=$5],#[fg=$6]}${window_right_separator:?}#[none]"

    echo "${separator_start}${text} ${separator_end}"
}

# Function: generate_status_module()
# Description:
#   creates the module string
#
# Parameters:
#   $1 (string) - the index of the module
#   $2 (string) - provided icon
#   $3 (string) - provided color
#   $4 (string) - provided text
#
# Output:
#   - return: the status module string
generate_status_module() {
    local index=$1
    local icon=$2
    local color=$3
    local text=$4

    local background=${PALLETE[bg]}
    if [ "$transparent" = "true" ]; then
        local background="default"
    fi

    case "$status_fill" in
    "icon")
        local show_icon="#[fg=${PALLETE[normal_black]},bg=$color,nobold,nounderscore,noitalics]$icon "
        local show_text="#[fg=${color},bg=${PALLETE[normal_black]}] $text"

        local show_left_separator="#[fg=$color,bg=$background,nobold,nounderscore,noitalics]$status_left_separator"
        local show_right_separator="#[fg=${PALLETE[normal_black]},bg=$background]$status_right_separator"
        ;;
    "all")
        local show_icon="#[fg=${PALLETE[normal_black]},bg=$color,nobold,nounderscore,noitalics]$icon "
        local show_text="#[fg=${PALLETE[normal_black]},bg=${color}] $text"

        local show_left_separator="#[fg=$color,bg=$background,nobold,nounderscore,noitalics]$status_left_separator"
        local show_right_separator="#[fg=$color,bg=$background]$right_separator"
        ;;
    *) ;;
    esac

    # NOTE: Disable inverse separator option for now
    # TODO: Fix this
    status_right_separator_inverse="false"
    if [ "$status_right_separator_inverse" = "true" ]; then
        local show_right_separator="#[fg=$background,bg=${color}]$status_left_separator"
    fi

    echo "$show_left_separator$show_icon$show_text$show_right_separator"
}

# Function: generate_window_icon()
# Description:
#   overrides the default icons
#
# Parameters:
#   -
#
# Output:
#   - return: the updated icons string
generate_window_icon() {
    if [ "$window_status_icon_enable" = "true" ]; then
        local show_window_status="#{?window_activity_flag,${icon_window_activity},}#{?window_bell_flag,${icon_window_bell},}#{?window_silence_flag,${icon_window_silent},}#{?window_active,${icon_window_current},}#{?window_last_flag,${icon_window_last},}#{?window_marked_flag,${icon_window_mark},}#{?window_zoomed_flag,${icon_window_zoom},} "
    else
        local show_window_status="#F"
    fi

    echo "$show_window_status"
}

# Function: generate_window()
# Description:
#   creates the window string
#
# Parameters:
#   $1 (string) - the formatted number string
#   $2 (string) - provided number color
#   $3 (string) - provided background text color
#   $4 (string) - provided foreground text color
#   $5 (string) - provided text
#   $6 (string) - how much to fill: "none", "number", "all"
#
# Output:
#   - return: the window string
generate_window() {
    local number=$1
    local color=$2
    local color_bg=$3
    local color_fg=$4
    local text=$5
    local fill=$6

    local background=${PALLETE[bg]}
    if [ "$transparent" = "true" ]; then
        local background="default"
    fi

    if [ "$window_status_enable" = "true" ]; then
        local icon="$(generate_window_icon)"
        text="$text $icon"
    fi

    case "$fill" in
    "none")
        local show_number="#[fg=${PALLETE[fg]},bg=${PALLETE[bright_black]}]$number "
        local show_middle_separator="#[fg=${PALLETE[normal_black]},bg=${PALLETE[bright_black]},nobold,nounderscore,noitalics]$window_middle_separator"
        local show_text="#[fg=${PALLETE[fg]},bg=${PALLETE[normal_black]}]$text"

        local show_left_separator="#[fg=${PALLETE[bright_black]},bg=$background,nobold,nounderscore,noitalics]$window_left_separator"
        local show_right_separator="#[fg=${PALLETE[normal_black]},bg=$background]$window_right_separator"
        ;;
    "number")
        local show_number="#[fg=${color_bg},bg=$color]$number "
        local show_middle_separator="#[fg=${color_bg},bg=${color},nobold,nounderscore,noitalics]$window_middle_separator"
        local show_text="#[fg=${color_fg},bg=${color_bg}]$text"

        local show_left_separator="#[fg=$color,bg=$background,nobold,nounderscore,noitalics]$window_left_separator"
        local show_right_separator="#[fg=${color_bg},bg=$background]$window_right_separator"
        ;;
    "all")
        local show_number="#[fg=${color_bg},bg=$color]$number "
        local show_middle_separator="#[fg=${color},bg=${color},nobold,nounderscore,noitalics]$window_middle_separator"
        local show_text="#[fg=${color_bg},bg=${color}]$text"

        local show_left_separator="#[fg=$color,bg=$background,nobold,nounderscore,noitalics]$window_left_separator"
        local show_right_separator="#[fg=${color},bg=$background]$window_right_separator"
        ;;
    *) ;;
    esac

    echo "$show_left_separator$show_number$show_middle_separator$show_text$show_right_separator"

}
