
tell application "Google Chrome"
	set found_video to false
	set window_list to every window
	repeat with the_window in window_list
		if found_video is equal to true then
			exit repeat
		end if
		set tab_list to every tab in the_window
		repeat with the_tab in tab_list
			if the title of the_tab contains "Udemy" or the title of the_tab contains "Youtube" then
				tell the_tab
                    -- look for the play button
					execute javascript "var udemyPlayButton = document.querySelector('button[data-purpose|=video-play');"
					execute javascript "var udemyVideo = document.querySelector('video');"

					execute javascript "var youtubePlayButton = document.querySelector('button.ytp-play-button');"
                    
                    -- if there is a play button, play it
                    -- else, if there is no play button, the video is currently playing. pause the video
					execute javascript "udemyPlayButton ? udemyPlayButton.click() : udemyVideo.pause()"
					execute javascript "youtubePlayButton.click()"
				end tell
				set found_video to true
				exit repeat
			end if
		end repeat
	end repeat
end tell