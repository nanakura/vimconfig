local wezterm = require 'wezterm'
local act = wezterm.action
return {
        colors = custom,
                window_close_confirmation = 'AlwaysPrompt',--不用确认关闭
        enable_tab_bar = false,--不显示bar
        enable_scroll_bar= false,--不显示滚动条
        --window_decorations = "RESIZE",--去掉标题栏
        --color_scheme = "Grape",
        color_scheme = "Banana Blueberry",
        window_padding = { left = 0, right = 0, top = 0, bottom = 0, },--窗口边距

        --text_background_opacity = 0,--字体透明度
        window_background_opacity =10,--背景不透明度

        --window_background_image = 'C:/Users/Administrator/Desktop/1.jpg',
        --[[window_background_image_hsb = {
                                brightness = 0,--背景亮度
                                hue = 0.5,--色度
                                saturation = 1,--灰度
                },]]--

        freetype_load_target = 'Light',--抗锯齿
        freetype_render_target = 'HorizontalLcd',

  font = wezterm.font("SauceCodePro Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"}),

  font_rules = {
    {
      italic = true,
      font = wezterm.font("SauceCodePro Nerd Font Mono", {weight="Regular", stretch="Normal", style="Italic"}),
    },
    {
      intensity = "Bold",
      font = wezterm.font("SauceCodePro Nerd Font Mono", {weight="Bold", stretch="Normal", style="Normal"}),
    },
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font("SauceCodePro Nerd Font Mono", {weight="Bold", stretch="Normal", style="Italic"})
    },
  },

        font_size=10,

        keys = {
                { key = 'c', mods = 'ALT', action = 'Copy', },
                { key = 'v', mods = 'ALT', action = 'Paste', },
                { key = 'u', mods = 'ALT', action =act.ScrollByLine(-1) },
                { key = 'd', mods = 'ALT', action =act.ScrollByLine(1) },
                { key = 'u', mods = 'CTRL | ALT', action = act.ScrollByPage(-0.5) },
                { key = 'd', mods = 'CTRL | ALT', action = act.ScrollByPage(0.5) },
                { key = 'q', mods = 'ALT', action = act.CloseCurrentPane { confirm = true },},
                { key = 'm',mods = 'ALT | CTRL',action = act.ToggleFullScreen,},
        },
}
