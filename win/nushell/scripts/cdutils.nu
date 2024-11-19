
def map-get [key] {
  try {
    $env.cdu.path-alias | get $key
  } catch {
    $key
  }
}

def empty-default [value] {
  if ($in | is-empty) {
    $value
  } else {
    $in
  }
}

def part-join [parts] {
  match $parts {
    []          => '.'
    [$h, ..$rp] => {
      map-get $h | append $rp
      | path join | path expand
    }
  }
}

def ls-dn [path] {
  ls $path -s | where type == dir | get name
}

def parse-input [input] {
  $input | str trim -l | split row -r '\s+' | skip 1
}

def helper [input] {
  match (parse-input $input) {
    [] | [ '' ] => { $env.cdu.path-alias | columns }
    [ '.' ]     => { ls-dn '.' }
    [ $h ]      => {
      $env.cdu.path-alias | columns | append (ls-dn '.')
      | uniq
    }
    $parts      => {
      ls-dn (part-join ($parts | drop 1))
    }
  }
}

export def --env cdi [path: string] {
  $in | empty-default $path | empty-default '~/Self' | cd $in
}

export def --env cdt [...parts: string@helper] {
  match $parts {
    [] => [ Self ]
    _  => $parts
  } | part-join $in | cd $in
}

