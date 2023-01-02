tell application "Google Chrome"
  set found_video to false
  set window_list to every window
  repeat with the_window in window_list
    if found_video is equal to true then
      exit repeat
    end if
    set tab_list to every tab in the_window
    repeat with the_tab in tab_list
      if the title of the_tab contains "Udemy" 
        tell the_tab
          -- problem: playing the video does not dismiss the button from the screen if the button is already present
          execute javascript "var udemyExpandCollapseButton = document.querySelector('button[data-purpose|=theatre-mode-toggle-button');"

          execute javascript "udemyExpandCollapseButton.click()"
          -- display dialog "Hello World"
        end tell
        set found_video to true
        exit repeat
      end if
    end repeat
  end repeat
end tell
