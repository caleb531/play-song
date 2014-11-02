-- Reveal selected song in iTunes --

on alfred_script(query)
	
	tell application "iTunes"
		set songId to query as integer
		set song to (first track of playlist 2 whose database ID is songId)
		activate
		reveal song
	end tell
	
end alfred_script