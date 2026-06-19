def d-file [filename] {
  return { type: 'file', name: $filename }
}

def d-dir [dirname, children] {
  return { type: 'dir', name: $dirname, children: $children }
}

def d-dir-rec [dirname] {
  return { type: 'dir-rec', name: $dirname }
}

def safety-cp-file [src, dst] {
  cp $src $dst
}

def safety-cp-dir [src, dst] {
  cp -r $src ($dst | path join '..')
}

def cover [src, dst, filetree] {
  mkdir $dst
  match $filetree {
    { type: 'file', name: $name } => {
      safety-cp-file ($src | path join $name) ($dst | path join $name)
    }
    { type: 'dir', name: $name, children: $files } => {
      let src_path = ($src | path join $name)
      let dst_path = ($dst | path join $name)
      for $file in $files {
        cover $src_path $dst_path $file
      }
    }
    { type: 'dir-rec', name: $name } => {
      safety-cp-dir ($src | path join $name) ($dst | path join $name)
    }
  }
}

export def wezterm [] {
  let src_path = './wezterm'
  let dst_path = ($nu.home-dir | path join '.config' 'wezterm')
  cover $src_path $dst_path (d-file 'wezterm.lua')
}

export def nu [] {
  let src_path = './nushell'
  let dst_path = $nu.default-config-dir
  cover $src_path $dst_path (d-dir '.' [
    (d-file 'env.nu'),
    (d-file 'config.nu'),
    (d-dir-rec 'scripts'),
  ])
}

export def helix [] {
  let src_path = './helix'
  let dst_path = ($env.APPDATA | path join 'helix')
  cover $src_path $dst_path (d-file 'config.toml')
}

export def all [] {
  wezterm
  nu
  helix
}

