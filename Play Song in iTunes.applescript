-- Play selected song in iTunes --

on alfred_script(query)
	
	tell application "iTunes"
		set songId to query as integer
		set song to (first track whose database ID is songId)
		play song
	end tell
	
end alfred_script