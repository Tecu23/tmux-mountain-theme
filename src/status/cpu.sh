#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

get_percent() {
    case $(uname -s) in
    Linux)
        percent=$(LC_NUMERIC=en_US.UTF-8 top -bn2 -d 0.01 | grep "Cpu(s)" | tail -1 | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
        normalize_percent_len "$percent"
        ;;
    Darwin)
        cpuvalue=$(ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
        cpucores=$(sysctl -n hw.logicalcpu)
        cpuusage=$((cpuvalue / cpucores))
        percent="$cpuusage%"
        normalize_percent_len $percent
        ;;
    OpenBSD)
        cpuvalue=$(ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
        cpucores=$(sysctl -n hw.ncpuonline)
        cpuusage=$((cpuvalue / cpucores))
        percent="$cpuusage%"
        normalize_percent_len $percent
        ;;
    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        # TODO: Add windows compatibility
        ;;
    esac

}

get_load() {
    case $(uname -s) in
    Linux | Darwin | OpenBSD)
        loadavg=$(uptime | awk -F'[a-z]:' '{ print $2}' | sed 's/,//g')
        echo "$loadavg"
        ;;
    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        # TODO: Add windows compatibility
        ;;

    esac
}

cpu_label="$(get_load)"
cpu_percent="$(get_percent)"

status_cpu_icon=$(get_tmux_option "@mountain_theme_status_cpu_icon" " ")
status_cpu_accent_color=$(get_tmux_option "@mountain_theme_status_cpu_accent_color" "normal_magenta")
status_cpu_icon_color=$(get_tmux_option "@mountain_theme_status_cpu_icon_color" "bright_magenta")
status_cpu_text=$(get_tmux_option "@mountain_theme_status_cpu_text" "$cpu_percent")

export status_cpu_icon status_cpu_accent_color status_cpu_icon_color status_cpu_text
