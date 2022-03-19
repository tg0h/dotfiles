# directory containing log files (HOMEBREW_PREFIX defaults to /usr/local unless you manually specified otherwise)
# HOMEBREW_PREFIX/var/log/yabai/

# DEBUG
# view the last lines of the error log 
alias ydl='tail /opt/homebrew/var/log/yabai/yabai.err.log'
# view the last lines of the debug log
alias ydd='tail /opt/homebrew/var/log/yabai/yabai.out.log'


# Create space on the active display
alias yc='yabai -m space --create'
# Delete focused space and focus first space on display
alias yd='yabai -m space --destroy'
alias yqw='yabai -m query --windows'
