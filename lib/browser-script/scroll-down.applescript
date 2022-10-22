tell application "Brave Browser" to tell active tab of window 1
  -- execute javascript "window.scrollBy(0,400)"
  execute javascript "window.scrollBy({top: 350, behavior: 'smooth'})"
end tell

tell application "Google Chrome" to tell active tab of window 1
  -- execute javascript "window.scrollBy(0,400)"
  execute javascript "window.scrollBy({top: 350, behavior: 'smooth'})"
end tell
