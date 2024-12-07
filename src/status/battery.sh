#!/usr/bin/env bash

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$root_dir/../utils.sh"

tmux set-option -g @batt_icon_charge_tier8 '󰁹'
tmux set-option -g @batt_icon_charge_tier7 '󰂁'
tmux set-option -g @batt_icon_charge_tier6 '󰁿'
tmux set-option -g @batt_icon_charge_tier5 '󰁾'
tmux set-option -g @batt_icon_charge_tier4 '󰁽'
tmux set-option -g @batt_icon_charge_tier3 '󰁼'
tmux set-option -g @batt_icon_charge_tier2 '󰁻'
tmux set-option -g @batt_icon_charge_tier1 '󰁺'
tmux set-option -g @batt_icon_status_charged '󰚥'
tmux set-option -g @batt_icon_status_charging '󰂄'
tmux set-option -g @batt_icon_status_discharging '󰂃'
tmux set-option -g @batt_icon_status_unknown '󰂑'

status_battery_icon=$(get_tmux_option "@mountain_theme_status_battery_icon" "#{battery_icon}")
status_battery_accent_color=$(get_tmux_option "@mountain_theme_status_battery_accent_color" "normal_blue")
status_battery_icon_color=$(get_tmux_option "@mountain_theme_status_battery_icon_color" "bright_blue")
status_battery_text=$(get_tmux_option "@mountain_theme_status_battery_text" "#{battery_percentage}")

export status_battery_icon status_battery_accent_color status_battery_icon_color status_battery_text
