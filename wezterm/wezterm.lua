local wezterm = require "wezterm"

local config = wezterm.config_builder()

-- Set theme
config.color_scheme = "Catppuccin Mocha"

-- Set default font
config.font = wezterm.font "JetBrains Mono"

return config
