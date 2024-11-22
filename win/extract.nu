
def 'extract wezterm' [] {
  let src_path = ([
    $nu.home-path, '.config/wezterm', 'wezterm.lua'
  ] | path join)
  let dst_path = ([ '.', 'wezterm' ] | path join)
  cp $src_path $dst_path
}

def 'extract nu' [] {
  let src_paths = [
    env.nu, config.nu,
    scripts
  ] | each { |sub_path|
    $nu.default-config-dir | path join $sub_path
  }
  let dst_path = './nushell'
  for $src_path in $src_paths {
    cp -r $src_path $dst_path
  }
}

def 'extract helix' [] {
  let src_path = 'C:/Users/31090/AppData/Roaming/helix'
  let dst_path = './helix'
  cp -r $src_path $dst_path
}

extract wezterm
extract nu
extract helix
