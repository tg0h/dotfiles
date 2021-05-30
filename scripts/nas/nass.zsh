#!/usr/bin/expect -f
# !/usr/bin/expect -df
# docs: https://www.tcl-lang.org/man/expect5.31/expect.1.html
# -f - only useful when specified in the shebang, tells expect to run the commands below
# -d - debug mode

# SSH NAS SETUP ------------------------------------------------
#
# to set up ssh to the nas,
# copy your public key to the nas
# ssh-copy-id -i id_ed25519.pub <user>@<host>
# also set up the correct permissions for the nas folders
# sudo chmod 755 . - this is the user's home folder on the nas
# sudo chmod 755 ~/.ssh
# sudo chmod 644 ~/.ssh/authorized_keys
# SSH NAS SETUP ------------------------------------------------

# DEPENDENCIES ------------------------------------------------
#
# brew install expect
# env contains NAS_SSH_PASSWORD
# DEPENDENCIES ------------------------------------------------

# LOGS         ------------------------------------------------
#
# logs stored in /tmp/nas_expect.log
# LOGS         ------------------------------------------------

# get the NAS_SSH_PASSWORD env variable
# in Tcl, access an env variable with $env(env var name)
set nas_ssh_password $env(NAS_SSH_PASSWORD)

# log transcript of session
# -a - even if log_user is 0, display the logs
log_file -a /tmp/nas_expect.log

# timestamp is provided by expect
set timestamp [timestamp -format %Y-%m-%d_%H:%M]

send_log "#######################\r\n"
send_log "nas shutdown start: $timestamp\r\n"

# disable send/expect dialog logging to stdout. logging to the logfile is unchanged.
log_user 0

# default timeout is 10s
# set timeout -l

# spawn is a expect command, it runs a command which expect snoops on
spawn ssh -t thoreau@tardis sudo poweroff

# the regex is "unanchored" and does not need to match the entire string
expect "assword"
send "$nas_ssh_password\r"

# puts "hello"
# interact

# connection to tardis is closed
# expect "closed"

# returns 0 if not specified
expect eof
exit 

