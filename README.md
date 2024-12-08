# Mountain Theme for Tmux

A highly customizable Tmux theme plugin that updates and enriches your
Tmux status line. Designed for flexibility and aesthetics, it allows you
to fine-tune colors, icons, separators, and text to create a personalized
and visually appealing environment.

**Note:** This plugin is under active development.
Future improvements will include dynamic window number positioning,
user-defined window colors, and hex color support for even more customization options.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Configuration Overview](#configuration-overview)
4. [Available Options](#available-options)
   - [General Theme Options](#general-theme-options)
   - [Transparency](#transparency)
   - [Pane Borders](#pane-borders)
   - [Session Icon](#session-icon)
   - [Window Icons and Titles](#window-icons-and-titles)
   - [Window Separators and Fill Modes](#window-separators-and-fill-modes)
   - [Status Bar Configuration](#status-bar-configuration)
   - [Status Modules](#status-modules)
5. [Examples](#examples)
6. [Reloading Your Configuration](#reloading-your-configuration)
7. [Future Enhancements (TODOs)](#future-enhancements-todos)
8. [Troubleshooting](#troubleshooting)
9. [License](#license)

---

## Introduction

The Mountain Theme Tmux Plugin enhances your Tmux environment with a vibrant,
customizable status line theme. It integrates icons, colors, and text elements,
allowing you to tailor the appearance and functionality of your status line to your
preference. From adjusting icons and separators to modifying active/inactive window
formatting, this plugin puts you in full control.

---

## Installation

1. **Tmux Plugin Manager (TPM)** (Recommended):

   - Add to your `~/.tmux.conf`:

     ```bash
     set -g @plugin 'yourusername/mountain-theme-tmux-plugin'
     ```

   - Press `prefix + I` inside Tmux to install.

2. **Manual Installation**:

   - Clone the repository:

   ```bash
    git clone https://github.com/yourusername/mountain-theme-tmux-plugin.git ~/.tmux/plugins/mountain-theme-tmux-plugin
   ```

   - Add the following to your `~/.tmux.conf`:

   ```tmux
    run-shell ~/.tmux/plugins/mountain-theme-tmux-plugin/main.sh
   ```

---

## Configuration Overview

All configuration is done by setting Tmux user options (prefixed with `@mountain_theme_`) in your `~/.tmux.conf`. The plugin reads these options at startup or when the configuration is reloaded. Use the helper function `get_tmux_option` (provided by the plugin) to retrieve and apply these settings.

**Example:**

```tmux
# Set the theme variation to "fuji"
set -g @mountain_theme_variation "fuji"
```

After changing options, reload the Tmux configuration:

```bash
tmux source-file ~/.tmux.conf
```

---

## Available Options

### General Theme Options

- **`@mountain_theme_variation`**  
   **Default:** `fuji`  
   **Description:** Chooses a color palette variation. Additional
  palettes may be defined in `palletes/` directory.  
   **Example:**

  ```tmux
  set -g @mountain_theme_variation "fuji"
  ```

### Transparency

- **`@mountain_theme_transparent_bg`**  
   **Default:** `true`  
   **Description:** Makes the status bar background transparent.
  Set to `false` for a solid background.  
   **Example:**
  ```tmux
  set -g @mountain_theme_transparent_bg "false"
  ```

### Pane Borders

- **`@mountain_theme_active_pane_border_style`**  
   **Default:** `${PALLETE[normal_black]}`  
   **Description:** Color/style for the active pane border.
  Usually defined by the palette.  
   **Example:**

  ```tmux
  set -g @mountain_theme_active_pane_border_style "green"
  ```

- **`@mountain_theme_inactive_pane_border_style`**  
   **Default:** `${PALLETE[bright_black]}`  
   **Description:** Color/style for the inactive pane border.  
   **Example:**

  ```tmux
  set -g @mountain_theme_inactive_pane_border_style "grey"
  ```

### Session Icon

- **`@mountain_theme_session_icon`**  
   **Default:** ``  
   **Description:** Icon displayed to represent the current session.  
   **Example:**

  ```tmux
  set -g @mountain_theme_session_icon " "
  ```

### Window Icons and Titles

- **`@mountain_theme_bell_window_icon`**  
   **Default:** 󰂞
  **Description:** Icon used when a window has a bell event.

  ```tmux
  set -g @mountain_theme_bell_window_icon "󰂞 "
  ```

- **`@mountain_theme_mark_window_icon`**  
   **Default:** `󰃀`  
   **Description:** Icon displayed when a window is marked.

  ```tmux
  set -g @mountain_theme_mark_window_icon "󰃀"
  ```

- **`@mountain_theme_silent_window_icon`**  
   **Default:** `󰂛`  
   **Description:** Icon for a window with silence events.

  ```tmux
  set -g @mountain_theme_silent_window_icon "󰂛 "
  ```

- **`@mountain_theme_activity_window_icon`**
  **Default:** `󰖲`
  **Description:** Icon shown when a window has activity.

  ```bash
  set -g @mountain_theme_activity_window_incon "󰖲 "
  ```

- **`@mountain_theme_current_window_icon`**  
   **Default:** `󰖯`
  **Description:** Icon for the currently active window.

  ```tmux
  set -g @mountain_theme_current_window_icon "󰖯 "
  ```

- **`@mountain_theme_last_window_icon`**  
   **Default:** `󰖰`
  **Description:** Icon for the last window visited.

  ```tmux
  set -g @mountain_theme_last_window_icon "󰖰 "
  ```

- **`@mountain_theme_active_window_title`**  
   **Default:** `#W`  
   **Description:** Format for the active window title. `#W` is the window name placeholder.

  ```tmux
  set -g @mountain_theme_active_window_title "#W* "
  ```

- **`@mountain_theme_active_window_number`**  
   **Default:** `#I`  
   **Description:** Format for the active window number.
  `#I` is the window index placeholder.

  ```tmux
  set -g @mountain_theme_active_window_number "#I"
  ```

- **`@mountain_theme_inactive_window_title`**  
   **Default:** `#W`  
   **Description:** Format for the inactive window title.

  ```tmux
  set -g @mountain_theme_inactive_window_title "#W "
  ```

- **`@mountain_theme_inactive_window_number`**
  **Default:** `#I`  
   **Description:** Format for the inactive window number.

  ```tmux
  set -g @mountain_theme_inactive_window_number "#I"
  ```

### Window Separators and Fill Modes

- **`@mountain_theme_window_left_separator`**  
   **Default:** `█`  
   **Description:** Separator on the left side of the window.

  ```tmux
  set -g @mountain_theme_window_left_separator "█"
  ```

- **`@mountain_theme_window_middle_separator`**  
   **Default:** `█`  
   **Description:** Separator between the window number and text.

  ```tmux
  set -g @mountain_theme_window_middle_separator "█"
  ```

- **`@mountain_theme_window_right_separator`**  
   **Default:** `█`  
   **Description:** Separator on the right side of the window.

  ```tmux
  set -g @mountain_theme_window_right_separator "█"
  ```

- **`@mountain_theme_window_fill`**  
   **Default:** `number`  
   **Description:** How much of the window section is filled with styling.
  Possible values: `none`, `number`, `all`

  ```tmux
  set -g @mountain_theme_window_fill "number"
  ```

- **`@mountain_theme_window_status_enable`**  
   **Default:** `true`  
   **Description:** Whether to show window status icons and formatting.

  ```tmux
  set -g @mountain_theme_window_status_enable "false"
  ```

- **`@mountain_theme_window_status_icon_enable`**  
   **Default:** `true`  
   **Description:** Whether to display the custom window icons for current, last, activity, etc.

  ```tmux
  set -g @mountain_theme_window_status_icon_enable "false"
  ```

### Status Bar Configuration

- **`@mountain_theme_status_fill`**  
   **Default:** `icon`  
   **Description:** How status modules are styled. Possible values: `icon`, `all`

  ```tmux
  set -g @mountain_theme_status_fill "all"
  ```

- **`@mountain_theme_status_left_separator`**  
   **Default:** ``  
   **Description:** Left separator for the status modules.

  ```tmux
  set -g @mountain_theme_status_left_separator ""
  ```

- **`@mountain_theme_status_right_separator`**  
   **Default:** ``  
   **Description:** Right separator for the status modules.

  ```tmux
  set -g @mountain_theme_status_right_separator ""
  ```

- **`@mountain_theme_right_separator_inverse`**  
   **Default:** `false`  
   **Description:** Controls whether right separators are inverted.

  ```tmux
  set -g @mountain_theme_right_separator_inverse "false"
  ```

### Status Modules

- **`@mountain_theme_status_modules`**  
   **Default:** `datetime,application,user`  
   **Description:** Comma-separated list of modules to display on the right
  side of the status bar. Each module corresponds to a script found in `status/`.
  If the module script doesn’t exist, it will be skipped.
  **Current Implemented Modules**: `application,battery,cpu,datetime,directory,host,user,weather`
  **Note:** battery, cpu and weather requires the following plugins to work:

  ```tmux
  set -g @plugin 'tmux-plugins/tmux-battery'
  set -g @plugin 'tmux-plugins/tmux-cpu'
  set -g @plugin 'xamut/tmux-weather'
  ```

  **Example:**

  ```tmux
  set -g @mountain_theme_status_modules "datetime,application,user,host"
  ```

For each module (e.g., `user`), the following additional options may be available
(depending on the module’s script):

- **`@mountain_theme_status_<module>_icon`**
- **`@mountain_theme_status_<module>_accent_color`**
- **`@mountain_theme_status_<module>_icon_color`**
- **`@mountain_theme_status_<module>_text`**

**Example for user module:**

```tmux
set -g @mountain_theme_status_user_icon ""
set -g @mountain_theme_status_user_accent_color "normal_blue"
set -g @mountain_theme_status_user_icon_color "bright_blue"
set -g @mountain_theme_status_user_text " #(whoami)"
```

---

## Examples

**Simple Setup:**

```tmux
# Use the fuji palette
set -g @mountain_theme_variation "fuji"
# Keep the background transparent
set -g @mountain_theme_transparent_bg "true"
# Show datetime and user modules only
set -g @mountain_theme_status_modules "datetime,user"
```

**More Advanced Customization:**

```tmux
# Use a different session icon
set -g @mountain_theme_session_icon "⚙"
# Change window separator icons
set -g @mountain_theme_window_left_separator ""
set -g @mountain_theme_window_right_separator ""
# Show all modules and fill them fully
set -g @mountain_theme_status_modules "datetime,application,user"
set -g @mountain_theme_status_fill "all"
# Make the status bar non-transparent
set -g @mountain_theme_transparent_bg "false"`

```

---

## Reloading Your Configuration

After updating your `~/.tmux.conf`, apply the changes by running:

```bash
tmux source-file ~/.tmux.conf
```

---

## Future Enhancements (TODOs)

- **Window Number Position Logic**: Allow customizable placement of window numbers.
- **Override Window Colors**: Provide options for users to
  set custom colors for windows.
- **Hex Color Support**: Enable specifying colors in hex format for greater flexibility.
- **Enhanced README**: As new features are added, the README
  will be updated to document them.

---

## Troubleshooting

- **No Icons Visible?**  
   Make sure you have a font that supports Nerd Fonts or the icons in use.
- **Colors Look Off?**  
   Ensure that your terminal supports true color and run `tmux -2` if needed.
- **Module Not Showing?**  
   Confirm the module script exists in `status/` and that its name matches
  one of the entries in `@mountain_theme_status_modules`.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.
