local wezterm = require "wezterm"

local config = wezterm.config_builder()

-- Set theme
config.color_scheme = "Catppuccin Mocha"

-- Set default font
config.font = wezterm.font "JetBrains Mono"
config.font_size = 15

-- Configure tabbar
config.window_frame = {
  font_size = 15
}

return config
