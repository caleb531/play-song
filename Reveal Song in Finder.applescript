-- Reveal selected song in Finder --

on alfred_script(query)
	
	-- get song name from the given query (which is a database ID)
	tell application "iTunes"
		set songId to query as integer
		set song to (first track of playlist 2 whose database ID is songId)
		set songPath to location of song as text
	end tell
	
	-- reveal song file in Finder
	tell application "Finder"
		activate
		reveal alias songPath
	end tell
	
end alfred_script