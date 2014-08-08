on alfred_script(query)
	
	tell application "iTunes"
		if query is "null" then
			-- if no results were found, bring iTunes to the front
			activate
		else
			set songId to query as integer
			-- otherwise, play the given song
			set songList to (every track of playlist 2 whose database ID is songId)
			-- reveal track in iTunes
			set song to item 1 of songList
			activate
			reveal song
		end if
	end tell
	
end alfred_script