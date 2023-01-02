try
  tell application "Brave Browser" to tell active tab of window 1
      if title contains "Udemy" or title contains "Youtube" then
          execute javascript "let togglePlayVideo = () => {\n
        document.querySelectorAll('iframe').forEach(v => { v.src = v.src });\n
        document.querySelectorAll('video').forEach(v => { v.paused ? v.play() : v.pause() });\n
      };"
          execute javascript "togglePlayVideo()"
      else
        execute javascript "window.scrollBy({top: 350, behavior: 'instant'})"
      end if
  end tell
end try

try
  tell application "Google Chrome"
    tell active tab of window 1
      if title contains "Udemy" or title contains "Youtube" then
          execute javascript "let togglePlayVideo = () => {\n
        document.querySelectorAll('iframe').forEach(v => { v.src = v.src });\n
        document.querySelectorAll('video').forEach(v => { v.paused ? v.play() : v.pause() });\n
      };"
          execute javascript "togglePlayVideo()"
      else
        execute javascript "window.scrollBy({top: 350, behavior: 'instant'})"
      end if
    end tell
  end tell
end try
