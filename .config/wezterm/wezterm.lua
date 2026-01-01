local wezterm = require 'wezterm'
local act = wezterm.action

-- 创建配置对象
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

----------------------------------------------------------------
-- 1. 字体 (Font)
----------------------------------------------------------------
-- WezTerm 会自动查找系统安装的 Nerd Fonts
config.font = wezterm.font 'MesloLGS Nerd Font Mono'
config.font_size = 12.5
config.line_height = 1.1 -- 对应 Kitty 的 110%

----------------------------------------------------------------
-- 2. 窗口外观 (Window)
----------------------------------------------------------------
-- 对应 hide_window_decorations yes (保留调整大小的能力)
config.window_decorations = "RESIZE" 
-- 对应 window_padding_width 10
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- 初始窗口大小 (WezTerm 使用行列数而像素)
config.initial_cols = 160
config.initial_rows = 40

----------------------------------------------------------------
-- 3. 颜色与透明度 (Colors & Opacity)
----------------------------------------------------------------
-- WezTerm 内置了 Catppuccin Mocha，不需要手动复制十六进制码
config.color_scheme = 'Everforest Dark (Gogh)'
config.window_background_opacity = 0.85
-- 注意：MacOS 上需要设置 macos_window_background_blur 来实现模糊效果
config.macos_window_background_blur = 10 
config.enable_tab_bar = false
----------------------------------------------------------------
-- 4. 滚动与光标 (Scroll & Cursor)
----------------------------------------------------------------
config.scrollback_lines = 8000
config.default_cursor_style = 'BlinkingBlock' -- Block 样式
-- 1. 设置光标闪烁的频率 (单位：毫秒)
-- 默认是 800ms，设为 0 则禁止闪烁
config.cursor_blink_rate = 800
-- 2. 设置光标闪烁的“呼吸”动画曲线
-- 可选值: "Linear", "Constant" (无渐变), "EaseIn", "EaseOut", "EaseInOut"
-- "Constant" 会让光标像传统终端一样生硬地闪烁
-- "EaseInOut" 会让光标有柔和的呼吸感
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBar"
----------------------------------------------------------------
-- 5. 铃声 (Bell)
----------------------------------------------------------------
config.audible_bell = "Disabled"

----------------------------------------------------------------
-- 6. Tab 栏 (Tab Bar)
----------------------------------------------------------------
-- 模拟 Powerline 样式
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32


----------------------------------------------------------------
-- 7. Shell
----------------------------------------------------------------
-- 设置默认 Shell 为 zsh
config.default_prog = { '/bin/zsh' } -- 或者是 '/usr/bin/zsh'，视系统而定

----------------------------------------------------------------
-- 8. 快捷键 (Key Bindings)
----------------------------------------------------------------
config.keys = {
  -- 新窗口 (Ctrl+Shift+Enter)
  { key = 'Enter', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
  
  -- 关闭窗口/Tab (Ctrl+Shift+W)
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab{ confirm = false } },

  -- 分屏 (Split)
  -- 水平分屏 (左右) - Kitty: Ctrl+Shift+H
  { key = 'h', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  
  -- 垂直分屏 (上下) - Kitty: Ctrl+Shift+V (此处改为 S 以避免与粘贴冲突)
  { key = 's', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- 切换窗口 (Navigation)
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },

  -- 复制 / 粘贴
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
}

return config
