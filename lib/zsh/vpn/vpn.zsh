function ovpn(){
  # openvpn was installed with brew
  # need to update $PATH if brew openvpn is upgraded
  # run in --daemon mode?
  sudo openvpn $VPN_CONFIG_FILE
}
