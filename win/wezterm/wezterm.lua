local wezterm = require 'wezterm'

-- wezterm.on('window-config-reloaded', function(window, pane)
--   window:set_position(962, 38)
-- end)

return {
  -- 字体
  font_size = 10,
  font = wezterm.font_with_fallback({ 'VictorMono NF', '更纱黑体 Mono SC Nerd' }),
  font_rules = {
    { intensity = 'Normal', italic = false,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'Medium', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'Medium', }, }), },
    { intensity = 'Half', italic = false,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'DemiBold', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'DemiBold', }, }), },
    { intensity = 'Bold', italic = false,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'Bold', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'Bold', }, }), },
    { intensity = 'Normal', italic = true,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'Medium', style = 'Oblique', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'Medium', style = 'Italic', }, }), },
    { intensity = 'Half', italic = true,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'DemiBold', style = 'Oblique', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'DemiBold', style = 'Italic', }, }), },
    { intensity = 'Bold', italic = true,
      font = wezterm.font_with_fallback({
        { family = 'VictorMono NF', weight = 'Bold', style = 'Oblique', },
        { family = '更纱黑体 Mono SC Nerd', weight = 'Bold', style = 'Italic', }, }), },
  },
  -- 颜色主题
  -- color_scheme = 'Batman',
  -- 背景透明
  window_background_opacity = 0.83,
  text_background_opacity = 0.5,
  -- 窗口初始化大小
  initial_cols = 104,
  initial_rows = 46,
  -- 内边距
  window_padding = {
    left = 7, right = 7,
    top = 11, bottom = 9,
  },
  -- 关闭 tab 栏
  enable_tab_bar = false,
  -- 启动参数
  default_gui_startup_args = {
    -- 设置窗口位置
    'start', '--position', 'main:957,3'
  },
  -- 指定启动 shell
  default_prog = {
    'C:\\ProgramData\\chocolatey\\bin\\nu.exe -i',
    -- 'C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
    -- '-NoExit',
    -- '-Command', -- 'Start-Sleep -s 0.3 ; nu'
  },
}
