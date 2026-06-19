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

def extract [src, dst, filetree] {
  mkdir $dst
  match $filetree {
    { type: 'file', name: $name } => {
      safety-cp-file ($src | path join $name) ($dst | path join $name)
    }
    { type: 'dir', name: $name, children: $files } => {
      let src_path = ($src | path join $name)
      let dst_path = ($src | path join $name)
      for $file in $files {
        extract $src_path $dst_path $file
      }
    }
    { type: 'dir-rec', name: $name } => {
      safety-cp-dir ($src | path join $name) ($dst | path join $name)
    }
  }
}

def extract-wezterm [] {
  let src_path = ($nu.home-path | path join '.config' 'wezterm')
  let dst_path = './wezterm'
  extract $src_path $dst_path (d-file 'wezterm.lua')
}

def extract-nu [] {
  let src_path = $nu.default-config-dir
  let dst_path = './nushell'
  extract $src_path $dst_path (d-dir '.' [
    (d-file 'env.nu'),
    (d-file 'config.nu'),
    (d-dir-rec 'scripts'),
  ])
}

def extract-helix [] {
  let src_path = ($env.APPDATA | path join 'helix')
  let dst_path = './helix'
  extract $src_path $dst_path (d-file 'config.toml')
}

extract-wezterm
extract-nu
extract-helix
