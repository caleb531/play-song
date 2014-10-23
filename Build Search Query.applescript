-- Build search query for Google search  --

on alfred_script(query)
	
	tell application "iTunes"
	
		set songId to query as integer
		
		-- get song name from the given query (which is a database ID)
		set songList to (every track whose database ID is songId)
		set song to item 1 of songList
		set songName to name of song
		set songArtist to artist of song
		
		return (songName & " by " & songArtist)
		
	end tell
	
	
end alfred_script