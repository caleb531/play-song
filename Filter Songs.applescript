---- Filter Songs by the typed query ----

-- Configurable options --

-- limit number of songs to improve efficiency
set songLimit to 9
-- whether or not to retrieve album artwork for each result
set albumArtEnabled to true

-- Script parameters (do not change these) --

-- cache variables
set homeFolder to (path to home folder as text)
set libraryFolder to (path to library folder from user domain as text)
set cacheFolder to (libraryFolder & "Caches:")
set workflowDataFolder to (cacheFolder & "com.runningwithcrayons.Alfred-2:Workflow Data:")
set artworkFolderName to "com.calebevans.playsong"
set artworkFolderPath to (workflowDataFolder & artworkFolderName & ":")
set songArtworkNameSep to " | "
set defaultIconName to "icon-noartwork.png"

-- replace substring in string with another substring
on replace(replaceThis, replaceWith, originalStr)
	set AppleScript's text item delimiters to replaceThis
	set strItems to text items of originalStr
	set AppleScript's text item delimiters to replaceWith
	return strItems as text
end replace

-- escape XML reserved characters in the given string
on escapeXmlChars(str)
	set str to replace("&", "&amp;", str)
	set str to replace("<", "&lt;", str)
	set str to replace(">", "&gt;", str)
	return str
end escapeXmlChars

-- create Alfred result item as XML
on createItem(uid, arg, valid, title, subtitle, icon)
	global homeFolder, defaultIconName
	
	-- recognize file paths for the icon
	if icon begins with homeFolder then
		set icon to POSIX path of icon
	end if
	
	-- escape reserved XML characters
	set title to escapeXmlChars(title)
	set subtitle to escapeXmlChars(subtitle)
	if icon is not defaultIconName then
		set icon to escapeXmlChars(icon)
	end if
	
	return tab & "<item uid='" & uid & "' arg='" & arg & "' valid='" & valid & "'>
		<title>" & title & "</title>
		<subtitle>" & subtitle & "</subtitle>
		<icon>" & icon & "</icon>
	</item>" & return & return
	
end createItem

-- get path to album art for the given song
on getSongArtworkPath(theSong, songArtist, songAlbum)
	global albumArtEnabled, artworkFolderPath, artworkFolderName, songArtworkNameSep
	
	if albumArtEnabled is false then
		set songArtworkPath to defaultIconName
	else
		-- generate a unique identifier for that album
		set songArtworkName to (songArtist & songArtworkNameSep & songAlbum) as text
		-- remove forbidden path characters
		set songArtworkName to replace(":", "", songArtworkName) of me
		set songArtworkName to replace("/", "", songArtworkName) of me
		set songArtworkName to replace(".", "", songArtworkName) of me
		set songArtworkPath to (artworkFolderPath & songArtworkName & ".jpg")
		
		tell application "Finder"
			-- cache artwork if it's not already cached
			if not (songArtworkPath exists) then
				tell application "iTunes"
					set songArtworks to artworks of eachSong
					-- only save artwork if artwork exists for this song
					if (length of songArtworks) is 0 then
						-- use default iTunes icon if song has no artwork
						set songArtworkPath to defaultIconName
					else
						-- save artwork to file
						set songArtwork to data of (item 1 of songArtworks)
						set fileRef to open for access songArtworkPath with write permission
						write songArtwork to fileRef
						close access fileRef
					end if
				end tell
			end if
		end tell
	end if
	
	return songArtworkPath
	
end getSongArtworkPath

-- create album artwork cache
on createArtworkCache()
	global albumArtEnabled, artworkFolderPath, workflowDataFolder
	-- create album artwork folder if it does not exist
	if albumArtEnabled is true then
		tell application "Finder"
			if not (alias artworkFolderPath exists) then
				make new folder in workflowDataFolder with properties {name:artworkFolderName}
			end if
		end tell
	end if
end createArtworkCache

-- get song result list as XML string
on getResultListXml(query)
	global songLimit, defaultIconName
	
	-- search iTunes library for the given query
	tell application "iTunes"
		
		-- search Music playlist for songs matching query
		set allSongs to (search playlist 2 for query)
		
		-- create initial XML string
		set xml to "<?xml version='1.0'?>" & return & "<items>" & return & return
		
		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of allSongs is 0 then
			
			set xml to xml & createItem("no-results", "null", "no", "Not Found", ("No results for '" & query & "'"), defaultIconName) of me
			
		else
			
			set songIndex to 1
			
			-- loop through the results to create the XML data
			repeat with eachSong in allSongs
				
				-- limit number of results
				if songIndex is greater than songLimit then
					exit repeat
				end if
				
				-- get song information
				set songId to (get database ID of eachSong)
				set songName to name of eachSong
				set songArtist to artist of eachSong
				set songAlbum to album of eachSong
				set songKind to kind of eachSong
				
				-- filter out digital booklets
				if songKind is not "PDF Document" then
					
					set songArtworkPath to getSongArtworkPath(eachSong, songArtist, songAlbum) of me
					
					-- add song information to XML
					set xml to xml & createItem(("track-" & songId), songId, "yes", songName, songArtist, songArtworkPath) of me
					
					set songIndex to songIndex + 1
					
				end if
				
			end repeat
			
		end if
		
		set xml to xml & "</items>"
		
	end tell
	
	-- return XML data
	return xml
	
end getResultListXml

createArtworkCache()
getResultListXml("{query}")