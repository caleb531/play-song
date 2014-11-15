---- Filter genres by the typed query ----

-- load workflow configuration
do shell script "bash ./compile.sh"
set config to load script POSIX file (((do shell script "pwd") as text) & "/Configuration.scpt")

-- constructs genre result list as XML string
on getResultListXml(query)
	global config
	
	-- search iTunes library for the given query
	tell application "iTunes"
		
		-- search Music playlist for songs whose genre matches query
		set theSongs to (get every track of playlist 2 whose genre contains query and kind contains (songDescriptor of config))
		set theGenres to {}
		set songIndex to 1
		
		-- retrieve list of genres matching query
		repeat with theSong in theSongs
			
			-- limit number of results
			if songIndex is greater than (songLimit of config) then exit repeat
			
			-- add genre to list if not already present
			if genre of theSong is not in theGenres then
				set theGenres to theGenres & (genre of theSong)
			end if
			
			set songIndex to songIndex + 1
			
		end repeat
		
		-- create initial XML string
		set xml to createXmlHeader() of config
		
		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theSongs is 0 then
			
			set xml to xml & createXmlItem("no-results", "null", "no", "No Genres Found", ("No genres matching '" & query & "'"), defaultIconName of config) of config
			
		else
			
			set songIndex to 1
			
			-- loop through the results to create the XML data
			repeat with genreName in theGenres
				
				set genreName to genreName as text
				set theSong to (first track whose genre is genreName and kind contains (songDescriptor of config))
				
				-- limit number of results
				if songIndex is greater than (songLimit of config) then exit repeat
				
				set songArtworkPath to getSongArtworkPath(theSong) of config
				
				-- add song information to XML
				set xml to xml & createXmlItem(("genre-" & genreName), genreName, "yes", genreName, "Genre", songArtworkPath) of config
				
				set songIndex to songIndex + 1
				
			end repeat
			
		end if
		
		set xml to xml & createXmlFooter() of config
		
	end tell
	
	return xml
	
end getResultListXml

createArtworkCache() of config
getResultListXml("{query}")