
alias pwsh = powershell

module clipboard {

  # 通过 powrshell 与剪贴板进行交互的命令
  # 如果有输入或参数则向剪贴板内写入内容
  # 不带输入参数输出剪贴板内容
  export def clip [
    x? : string     # 输入到剪贴板的内容
  ] {
    if ($in | is-empty) {
      if ($x | is-empty) {
        get
      } else {
        set $x
      }
    } else {
      set ($in | into string)
    }
  }

  def get [] {
    powershell -c 'Get-Clipboard' | decode utf-8
  }

  def set [x : string] {
    powershell -c $'Set-Clipboard "($x)"'
  }
}

def empty-default [default] {
  if ($in | is-empty) { $default } else { $in }
}

$env.cdu = [ 
  [ Home, '~' ],
  [ Self, '~/Self' ],
  [ Project, '~/Self/Project' ],
  [ Blog, '~/Self/Project/Blog/git-blog' ],
]
  
module cdu {

  def map-col [] {
    $env.cdu | each { |x| $x | get 0 }
  }

  def map-get [key] {
    $env.cdu | filter { |x|
      ($x | get 0) == $key
    } | if ($in | is-empty) {
      $key
    } else {
      $in | get 0 | get 1
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

  def ls-f [path: string, p: string] {
    ls-dn $path | filter { |x| $x | str starts-with $p }
  }

  def helper [input] {
    let parts = parse-input $input
    match $parts {
      [] => map-col
      [ '' ] => map-col
      [ '.' ] => { ls-dn '.' }
      [ $h ] => {
        map-col | append (ls-dn '.')
        | filter { |x| $x | str starts-with -i $h }
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
    $parts | part-join $in | cd $in
  }

}

use clipboard clip
use cdu [ cdt, cdi ]

