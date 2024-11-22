
def get [] {
  win32yank -o
  # 旧版本
  # powershell -c 'Get-Clipboard' | decode utf-8
}

def set [x : string] {
  echo $x | win32yank -i
  # 旧版本
  # powershell -c $'Set-Clipboard "($x | into string)"'
}

# 如果有输入或参数则向剪贴板内写入内容, 不带输入参数输出剪贴板内容
export def clip [
  x? : string     # 输入到剪贴板的内容
] {
  if ($in | is-empty) {
    if ($x | is-empty) { get } else { set $x }
  } else {
    set $in
  }
}

export def 'clip sl' [] {
  clip
  | str replace (char crlf) (char lf) -a
  | str replace $'-(char lf)' '' -a
  | str replace "\n" " " -a
  | str replace '"' '`"' -a
  | str trim | clip
}
