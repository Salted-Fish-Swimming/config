
alias pwsh = powershell

module clipboard {

  # 通过 powrshell 与剪贴板进行交互的命令
  # 如果有输入或参数则向剪贴板内写入内容
  # 不带输入参数输出剪贴板内容
  export def clip [
    x? : string     # 输入到剪贴板的内容
  ] {
    if ($in | is-empty) {
      if ($x | is-empty) { get } else { set $x }
    } else {
      set $in
    }
  }

  def get [] {
    powershell -c 'Get-Clipboard' | decode utf-8
  }

  def set [x : string] {
    print 'set clip'
    | powershell -c $'Set-Clipboard "($in)"'
  }
}

use clipboard clip

def 'clip sl' [] {
  clip
  | str replace (char crlf) (char lf) -a
  | str replace $'-(char lf)' '' -a
  | str replace (char lf) ' ' -a
  | str trim | clip
}

def empty-default [default] {
  if ($in | is-empty) { $default } else { $in }
}

$env.cdu = { 
  Home: '~',
  Self: '~\Self',
  Project: '~\Self\Project',
  Blog: '~\Self\Project\Blog\git-blog',
  Config: '~\Self\Project\Git\Self\config',
  Git: '~\Self\Project\Git',
}
  
module cdu {

  def map-get [key] {
    try {
      $env.cdu | get $key
    } catch {
      $key
    }
  }

  def part-join [parts] {
    match $parts {
      [] => '.'
      [$h, ..$p] => {
        map-get $h | path join ($p | default [] | path join)
      }
    }
  }

  def ls-dn [path] {
    ls $path | where type == dir | get name | path basename
  }

  def parse-input [input] {
    $input | str trim -l | split row -r '\s+' | skip 1
  }

  def helper [input] {
    let parts = parse-input $input
    match $parts {
      [] | [ '' ] => { $env.cdu | columns }
      [ '.' ] => { ls-dn '.' }
      [ $h ] => {
        $env.cdu | columns | append (ls-dn '.')
        | filter { |x| $x | str starts-with -i $h }
        | uniq
      }
      _ => {
        ls-dn (part-join ($parts | drop 1))
      }
    }
  }

  export def-env cdi [path: string] {
    $in | empty-default $path | empty-default '~' | cd $in
  }

  export def-env cdt [...parts: string@helper] {
    match $parts {
      [] => [ Self ]
      _ => $parts
    } | part-join $in | cd $in
  }

}

use cdu [ cdt, cdi ]

