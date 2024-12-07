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

    left_separator=""
    right_separator=""

    separator_start="#[bg=default]#{?client_prefix,#[fg=$5],#[fg=$6]}${left_separator:?}"
    text="#{?client_prefix,#[bg=$5],#[bg=$6]}#[fg=$7,bold]${session_icon} #S"
    separator_end="#[bg=default]#{?client_prefix,#[fg=$5],#[fg=$6]}${right_separator:?}#[none]"

    echo "${separator_start}${text} ${separator_end}"
}

# Function: generate_window_string()
# Description:
#   creates the window string (either active / inactive) string for the tmux status bar
#
# Parameters:
#   $1  (string) - window icon
#   $2  (string) - zoomed window icon
#   $3  (string) - synchronized pane icon
#   $4  (string) - the left separator
#   $5  (string) - the middle separator
#   $6  (string) - the right separator
#   $7  (string) - whether the background is transparent or not
#   $8  (string) - the window text formatting
#   $9  (string) - number background color
#   $10 (string) - text background color
#   $11 (string) - text foreground color
#   $12 (string) - background color (when non-transparent)
#
# Output:
#   - return: the session string
generate_window_string() {
    local left_separator=$4
    local middle_separator=$5
    local right_separator=$6
    local transparent=$7
    local active_window_title=$8

    separator_start="#[bg=default,fg=$9]${left_separator}#[none]"
    number="#[bg=$9]#[fg=${11}]#I "
    separator_middle="#[bg=${10},fg=${10}]${middle_separator}#[none]"
    separator_end="#[bg=default,fg=${10}]${right_separator}#[none]"

    echo "${separator_start}${number}${separator_middle}#[fg=${11}]#{?window_zoomed_flag,$2,$1}${active_window_title}#{?pane_synchronized,$3,}${separator_end}#[none]"
}
