-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'tokyonight_night'
config.default_domain = 'WSL:Ubuntu'

-- and finally, return the configuration to wezterm
return config
