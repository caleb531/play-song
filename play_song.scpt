on alfred_script(query)
	
	tell application "iTunes"
		if query is "null" then
			-- if no results were found, bring iTunes to the front
			activate
		else
			-- otherwise, play the given song ID
			set songId to query as integer
			set songList to (every track whose database ID is songId)
			-- play track
			set song to item 1 of songList
			play song
		end if
	end tell
	
end alfred_script