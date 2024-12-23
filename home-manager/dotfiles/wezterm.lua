wezterm = require "wezterm"

local config = wezterm.config_builder()

config.font = wezterm.font('IBM Plex Mono', { size = 12 })

return config