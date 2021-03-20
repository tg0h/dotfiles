# install ios ipa
function idi() {
  ideviceinstaller -i $1
}

# run logs
function idl() {
  # -n connect to network device
  # -p connect to process named Runner
  idevicesyslog -n -p Runner
}
