#!/usr/bin/env bash

# setting the locale, some users have issues with different locales, this enforces the correct one
export LC_ALL=en_US.UTF-8

# Run utils scripts
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=src/utils.sh
source "$current_dir/utils.sh"

main() {

    # set configuration option variables
    theme_variation=$(get_tmux_option "@mountain_theme_variation" "fuji")

    # shellcheck source=src/palletes/fuji.sh
    . "$current_dir/palletes/$theme_variation.sh"

    ### Load Options
    transparent=$(get_tmux_option "@mountain_theme_transparent_bg" "false")

    if [ "$transparent" = "true" ]; then
        right_separator_inverse=$(get_tmux_option "@theme_transparent_right_separator_inverse", "")
    fi

    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100

    # status bar
    status_bar_bg=${PALLETE[bg]}
    if [ "$transparent" = "true" ]; then
        status_bar_bg="default"
    fi
    tmux set-option -g status-style "bg=${status_bar_bg},fg=${PALLETE[fg]}"
}

# run main function
main
