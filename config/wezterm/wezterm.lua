local wezterm = require("wezterm")
local config = wezterm.config_builder()

local config_dir = os.getenv("XDG_CONFIG_HOME") .. "/wezterm"

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Frappe"
	end
end

config.font = wezterm.font("ComicShannsMono Nerd Font", { weight = "Bold", italic = false })
config.font_size = 16

config.window_background_image = config_dir .. "/bg.jpeg"

config.enable_tab_bar = false

config.window_background_image_hsb = {
	brightness = 0.035,
	hue = 1.0,
	saturation = 1.0,
}

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.enable_wayland = true

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

return config
