#!/usr/bin/env bash

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"

    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

# Function: generate_session_string()
# Description:
#   creates the session string for the tmux status bar
#
# Parameters:
#   $1 (string) - the session icon
#   $2 (string) - the left separator
#   $3 (string) - whether the background is transparent or not
#   $4 (string) - background color for client prefix
#   $5 (string) - default background color
#   $6 (string) - foreground color
#
# Output:
#   - return: the session string
generate_session_string() {
    local session_icon="$1"
    local left_separator="$2"

    if [ "$transparent" = "true" ]; then
        local separator_end="#[bg=default]#{?client_prefix,#[fg=$4],#[fg=$5]}${left_separator:?}#[none]"
    else
        local separator_end="#[bg=default]#{?client_prefix,#[fg=$4],#[fg=$5]}${left_separator:?}#[none]"
    fi

    echo "#[fg=$9,bold]#{?client_prefix,#[bg=$4],#[bg=$5]} ${session_icon} #S ${separator_end}"
}

# Function: generate_window_string()
# Description:
#   creates the window string (either active / inactive) string for the tmux status bar
#
# Parameters:
#   $1 (string) - window icon
#   $2 (string) - zoomed window icon
#   $3 (string) - synchronized pane icon
#   $4 (string) - the left separator
#   $5 (string) - whether the background is transparent or not
#   $6 (string) - the window text formatting
#   $7 (string) - number background color
#   $8 (string) - text background color
#   $9 (string) - text foreground color
#   $10 (string) - background color (when non-transparent)
#
# Output:
#   - return: the session string
generate_window_string() {
    local left_separator=$4
    local transparent=$5
    local active_window_title=$6

    if [ "$transparent" = "true" ]; then
        left_separator_inverse=$(get_tmux_option "@theme_transparent_left_separator_inverse" '')

        separator_start="#[bg=default,fg=$7]${left_separator_inverse}#[bg=$7,fg=$9]"

        separator_internal="#[bg=$8,fg=$7]${left_separator:?}#[none]"
        separator_end="#[bg=default,fg=$8]${left_separator:?}#[none]"
    else
        separator_start="#[bg=$8,fg=${10}]${left_separator:?}#[none]"
        separator_internal="#[bg=$8,fg=$7]${left_separator:?}#[none]"
        separator_end="#[bg=${10},fg=$8]${left_separator:?}#[none]"
    fi

    echo "${separator_start}#[fg=$9]#I${separator_internal}#[fg=${9}] #{?window_zoomed_flag,$2,$1}${active_window_title}#{?pane_synchronized,$3,}${separator_end}#[none]"
}

# Function: normalize_percent_len()
# Description:
#  normalize the percentage string to always have a length of 5
#
# Parameters:
#   $1 (int) - the current length of the percentage
#
# Output:
#   - return: formatted percentage
normalize_percent_len() {
    local max_len=5
    local percent_len=${#1}

    local diff_len=$max_len-$percent_len

    local left_spaces=$(($((diff_len + 1)) / 2))
    local right_spaces=$((diff_len / 2))

    printf "%${left_spaces}s%s%${right_spaces}s\n" "" "$1" ""
}
