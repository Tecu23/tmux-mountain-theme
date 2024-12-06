#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

linux_acpi() {
    arg=$1
    BAT=$(ls -d /sys/class/power_supply/*)
    if [ ! -x "$(which acpi 2>/dev/null)" ]; then
        for DEV in $BAT; do
            case "$arg" in
            status)
                [ -f "$DEV/status" ] && cat "$DEV/status"
                ;;
            percent)
                [ -f "$DEV/capacity" ] && cat "$DEV/capacity"
                ;;
            *) ;;
            esac
        done
    else
        case "$arg" in
        status)
            acpi | cut -d: -f2- | cut -d, -f1 | tr -d ' '
            ;;
        percent)
            acpi | cut -d: -f2- | cut -d, -f2 | tr -d '% '
            ;;
        *) ;;
        esac
    fi
}

battery_percent() {
    # Check OS
    case $(uname -s) in
    Linux)
        percent=$(linux_acpi percent)
        [ -n "$percent" ] && echo "$percent%"
        ;;
    Darwin)
        echo $(pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%')
        ;;
    FreeBSD)
        echo $(apm | sed '8,11d' | grep life | awk '{print $4}')
        ;;
    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        # TODO: Add windows compatibility
        ;;
    *) ;;
    esac
}

battery_status() {
    # Check OS
    case $(uname -s) in
    Linux)
        status=$(linux_acpi status)
        ;;
    Darwin)
        status=$(pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " ")
        ;;
    FreeBSD)
        status=$(apm | sed '8,11d' | grep Status | awk '{printf $3}')
        ;;
    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        # TODO: Add windows compatibility
        ;;
    *) ;;
    esac

    tmp_bat_perc=$(battery_percent)
    bat_perc="${tmp_bat_perc%\%}"

    case $status in
    discharging | Discharging | "Not charging")
        # discharging, no AC
        declare -A battery_labels=(
            [0]="󰂎"
            [10]="󰁺"
            [20]="󰁻"
            [30]="󰁼"
            [40]="󰁽"
            [50]="󰁾"
            [60]="󰁿"
            [70]="󰂀"
            [80]="󰂁"
            [90]="󰂂"
            [100]="󰁹"
        )
        echo "${battery_labels[$((bat_perc / 10 * 10))]:-󰂃}"
        ;;
    high | charged | Full)
        echo "󰁹"
        ;;
    charging | Charging)
        # charging from AC
        declare -A battery_labels=(
            [0]="󰢟"
            [10]="󰢜"
            [20]="󰂆"
            [30]="󰂇"
            [40]="󰂈"
            [50]="󰢝"
            [60]="󰂉"
            [70]="󰢞"
            [80]="󰂊"
            [90]="󰂋"
            [100]="󰂅"
        )
        echo "${battery_labels[$((bat_perc / 10 * 10))]:-󰂃}"
        ;;
    ACattached)
        # drawing from AC but not charging
        echo ''
        ;;
    finishingcharge)
        echo '󰂅'
        ;;
    *)
        # something wrong...
        echo ''
        ;;
    esac
}

bat_perc="$(battery_percent)"

status_battery_icon=$(get_tmux_option "@mountain_theme_status_battery_icon" "$(battery_status) ")
status_battery_accent_color=$(get_tmux_option "@mountain_theme_status_battery_accent_color" "normal_blue")
status_battery_icon_color=$(get_tmux_option "@mountain_theme_status_battery_icon_color" "bright_blue")
status_battery_text=$(get_tmux_option "@mountain_theme_status_battery_text" " $bat_perc")

export status_battery_icon status_battery_accent_color status_battery_icon_color status_battery_text
