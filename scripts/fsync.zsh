#!/usr/local/bin/zsh
# the plist file is stored in ~/Library/LaunchAgents/fsync.plist
# see http://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs/
# and https://freefilesync.org/

# SAMPLE fsync.plist file stored in ~/Library/LaunchAgents/fsync.plist:
# <?xml version="1.0" encoding="utf-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
#    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
#   <dict>
#     <key>Label</key>
#     <string>tim.fsync</string>
#     <key>ProgramArguments</key>
#     <array>
#       <string>/Users/tim/dotfiles/scripts/fsync.zsh</string>
#     </array>
#     <key>Nice</key>
#     <integer>1</integer>
#     <key>StartCalendarInterval</key>
#     <dict>
#       <key>Hour</key>
#       <integer>9</integer>
#     </dict>
#     <key>RunAtLoad</key>
#     <true />
#     <key>StandardErrorPath</key>
#     <string>/tmp/fsync/fsync.err</string>
#     <key>StandardOutPath</key>
#     <string>/tmp/fsync/fysnc.out</string>
#   </dict>
# </plist>

# The fsync command will not be found, you need to source the zsh function first
# fsync 

# add the path to FreeFileSync
path=('/usr/local/bin' $path) # add homebrew packages

FreeFileSync ~/certis/.certisSync.ffs_batch

echo fysnc done at $(date)

