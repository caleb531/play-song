-- Reveal selected song in iTunes --

on alfred_script(query)
	
	if query is not "null" then
		tell application "iTunes"
			set songId to query as integer
			-- otherwise, play the given song
			set songList to (every track of playlist 2 whose database ID is songId)
			-- reveal track in iTunes
			set song to item 1 of songList
			activate
			reveal song
		end tell
	end if
	
end alfred_script