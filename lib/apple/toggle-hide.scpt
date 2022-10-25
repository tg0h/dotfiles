#!/usr/bin/osascript

on run argv

set appName to item 1 of argv

tell application "System Events"
    if visible of application process appName is true then
        set visible of application process appName to false
    else
        set visible of application process appName to true
    end if
end tell
end run
