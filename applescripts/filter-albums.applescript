---- Filters albums by the typed query ----

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs album result list as XML string
on getResultListXml(query)
	global config
	
	-- search iTunes library for the given query
	tell application "iTunes"
		
		-- search Music playlist for songs whose album matches query
		set theSongs to (get every track of playlist 2 whose album contains query and kind contains (songDescriptor of config))
		set theAlbums to {}
		set theIndex to 1
		
		-- retrieve list of albums matching query
		repeat with theSong in theSongs
			
			-- limit number of results
			if theIndex is greater than (resultLimit of config) then exit repeat
			
			-- add album to list if not already present
			if album of theSong is not in theAlbums then
				set theAlbums to theAlbums & (album of theSong)
				set theIndex to theIndex + 1
			end if
			
		end repeat
		
		-- create initial XML string
		set xml to createXmlHeader() of config
		
		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theAlbums is 0 then
			
			set xml to xml & createXmlItem("no-results", "null", "no", "No Albums Found", ("No albums matching '" & query & "'"), defaultIconName of config) of config
			
		else
			
			-- loop through the results to create the XML data
			repeat with albumName in theAlbums
				
				set albumName to albumName as text
				set theSong to (first track of playlist 2 whose album is albumName and kind contains (songDescriptor of config))
				
				set songArtworkPath to getSongArtworkPath(theSong) of config
				
				-- add song information to XML
				set xml to xml & createXmlItem(("album-" & albumName), albumName, "yes", albumName, artist of theSong, songArtworkPath) of config
				
			end repeat
			
		end if
		
		set xml to xml & createXmlFooter() of config
		
	end tell
	
	return xml
	
end getResultListXml

createArtworkCache() of config
getResultListXml("{query}")
