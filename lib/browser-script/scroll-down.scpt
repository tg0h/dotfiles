try
  tell application "Brave Browser" to tell active tab of window 1
    execute javascript "window.scrollBy({top: 350, behavior: 'smooth'})"
  end tell
end try

try
  -- if udemy or chrome is active, do not scroll, start/stop the video instead
  tell application "Google Chrome"
    tell active tab of window 1
      if title contains "Udemy" then
        -- do nothing
      else
        execute javascript "window.scrollBy({top: 350, behavior: 'smooth'})"
      end if
    end tell
  end tell

  tell application "Google Chrome"
    set found_video to false
    set window_list to every window
    repeat with the_window in window_list
      if found_video is equal to true then
        exit repeat
      end if
      set tab_list to every tab in the_window
      repeat with the_tab in tab_list
        if the title of the_tab contains "Udemy" then
          tell the_tab
            -- problem: playing the video does not dismiss the button from the screen if the button is already present
            execute javascript "var udemyPlayButton = document.querySelector('button[data-purpose|=video-play');"
            execute javascript "var udemyVideo = document.querySelector('video');"

            execute javascript "udemyPlayButton ? udemyPlayButton.click(): (udemyVideo.paused ? udemyVideo.play() : udemyVideo.pause()) "
            execute javascript "udemyPlayButton.click()"
            -- display dialog "Hello World"
          end tell
          set found_video to true
          exit repeat
        end if
        if the title of the_tab contains "Youtube" then
          tell the_tab
            execute javascript "var video = document.querySelector('video');"
            execute javascript "video.click()"
          end tell
          set found_video to true
          exit repeat
        end if
      end repeat
    end repeat
  end tell
end try
