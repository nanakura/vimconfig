local wezterm = require 'wezterm'
local act = wezterm.action
return {
	colors = custom,
	enable_tab_bar = false,
	--color_scheme = "Gogh (Gogh)",
	color_scheme = "Grape",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0, },--窗口边距

	text_background_opacity = 0,--字体透明度
	window_background_opacity = 0.5,--背景不透明度

	--window_background_image = 'C:/Users/Administrator/Desktop/1.jpg',
	
	--[[window_background_image_hsb = {
		brightness = 0.1,--背景亮度
		hue = 1.0,--色度
		saturation = 1.0,--灰度 
	},]]--

	freetype_load_target = 'Light',--抗锯齿
	freetype_render_target = 'HorizontalLcd',
	font = wezterm.font 'UbuntuMono Nerd Font Mono',
	font_size=11,

	keys = {
		{ key = 'c', mods = 'ALT', action = 'Copy', },
		{ key = 'v', mods = 'ALT', action = 'Paste', },
		{ key = 'u', mods = 'ALT', action = act.ScrollByLine(-1) },
		{ key = 'd', mods = 'ALT', action = act.ScrollByLine(1) },
		{ key = 'u', mods = 'CTRL | ALT', action = act.ScrollByPage(-0.5) },
		{ key = 'd', mods = 'CTRL | ALT', action = act.ScrollByPage(0.5) },
	},
}
