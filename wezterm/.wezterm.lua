local wezterm = require("wezterm")

local config = wezterm.config_builder()
local home  = wezterm.home_dir

config.default_cwd = "~"

-- Font
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.line_height = 1.2

-- UI
-- config.color_scheme = 'Black Metal (Khold) (base16)'
-- config.color_scheme = 'Black Metal (Marduk) (base16)'
-- config.color_scheme = 'Black Metal (Nile) (base16)'
-- config.color_scheme = 'rose-pine'
config.color_scheme = 'Rosé Pine (base16)'
-- config.color_scheme = 'Rebecca (base16)'
-- config.color_scheme = 'Raycast_Dark'
-- config.color_scheme = 'Dracula (base16)'

config.colors = {
  background = "#000000",
  -- foreground = "#ffffff"
}

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 68
config.window_padding = {
  left = 10, 
  right = 10,
  top = 10,
  bottom = 5
}

--[[config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}-]]

-- Performance Settings
config.max_fps = 120
-- config.prefer_egl = true

return config

