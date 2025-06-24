local wezterm = require "wezterm"

-- Hook to run after GUI is ready
wezterm.on('gui-startup', function(cmd)
  local gui = wezterm.gui
  local window = gui.window_for_cmd(cmd or {})
  local display = window:get_display_info()
  local dpi = display.dpi or 96
  local font_size = 12.0 * (dpi / 96)

  window:set_config_overrides({
    font_size = font_size,
    window_frame = {
        font_size = font_size
    }
  })
end)

local config = wezterm.config_builder()

-- Set theme
config.color_scheme = "Catppuccin Mocha"

-- Set default font
config.font = wezterm.font "JetBrains Mono"

return config
