#!/usr/bin/env bash

# source and run theme
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$current_dir/src/theme.sh"
