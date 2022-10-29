-- if brave browser does not exist, this throws an error
-- wrap in a try block to swallow it so that the chrome block can continue
try
  tell application "Brave Browser" to tell active tab of window 1
      if title contains "Udemy" or title contains "Youtube" then
        -- do nothing
      else
        execute javascript "window.scrollBy({top: -350, behavior: 'smooth'})"
      end if
  end tell
end try

try
  tell application "Google Chrome" to tell active tab of window 1
      if title contains "Udemy" then
        execute javascript "var udemyExpandCollapseButton = document.querySelector('button[data-purpose|=theatre-mode-toggle-button');"
        execute javascript "udemyExpandCollapseButton.click()"
      else if title contains "Youtube" then
        -- do nothing
      else
        execute javascript "window.scrollBy({top: -350, behavior: 'smooth'})"
      end if
  end tell
end try
