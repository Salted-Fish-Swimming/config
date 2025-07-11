local wezterm = require 'wezterm'

return {
  -- 字体
  font_size = 12,
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
  initial_cols = 85,
  initial_rows = 37,
  -- 内边距
  window_padding = {
    left = 8, right = 8,
    top = 9, bottom = 4,
  },
  -- 关闭 tab 栏
  enable_tab_bar = true,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  --
  -- 启动参数
  default_gui_startup_args = {
    -- 设置起始时窗口位置
    'start', '--position', 'main:955,3'
  },
  -- 指定默认路径为当前窗口路径
  -- default_cwd = wezterm.home_dir,
  -- 指定启动 shell
  -- set_environment_variables = {
  --   COMSPEC =
  --     "C:\\Users\\31090\\AppData\\Local\\Programs\\nu\\bin\\nu.exe",
  -- },
  default_prog = {
    -- 'C:\\ProgramData\\chocolatey\\bin\\nu.exe', '-i',
    'C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
    -- '-NoExit',
    '-Command', 'nu'
  },
}
