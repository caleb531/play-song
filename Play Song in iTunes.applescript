-- Play selected song in iTunes --

on alfred_script(query)
	
	if query is not "null" then
		tell application "iTunes"
			set songId to query as integer
			set songList to (every track whose database ID is songId)
			-- play track
			set song to item 1 of songList
			play song
		end tell
	end if
	
end alfred_script