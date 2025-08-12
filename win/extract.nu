
def safety-cp-file [src, dst] {
  cp $src $dst
}

def safety-cp-dir [src, dst] {
  cp -r $src $dst
}

def extract [src, dst, filetree] {
  mkdir -v $dst
  match $filetree {
    { type: 'file', name: $name } => {
      safety-cp-file ($src | path join $name) ($dst | path join $name)
    }
    { type: 'dir', name: $name, files: $files } => {
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
  extract $src_path $dst_path {
    type: 'file', name: 'wezterm.lua'
  }
}

def extract-nu [] {
  let src_path = $nu.default-config-dir
  let dst_path = './nushell'
  extract $src_path $dst_path {
    type: 'file', name: 'env.nu'
  }
  extract $src_path $dst_path {
    type: 'file', name: 'config.nu'
  }
  extract $src_path $dst_path {
    type: 'dir-rec', name: 'scripts'
  }
}

def extract-helix [] {
  let src_path = ($env.APPDATA | path join 'helix')
  let dst_path = './helix'
  extract $src_path $dst_path {
    type: file, name: 'config.toml'
  }
}

extract-wezterm
extract-nu
extract-helix
