-- OPTIONS --

-- retrieve search query
set query to "{query}"
-- limit number of songs for maximum efficiency
set songLimit to 10
-- whether or not to retrieve album artwork for each result
set albumArtEnabled to true

-- SCRIPT --

-- cache variables
set homeFolder to (path to home folder as text)
set libraryFolder to (homeFolder & "Library:")
set cacheFolder to (libraryFolder & "Caches:")
set workflowDataFolder to (cacheFolder & "com.runningwithcrayons.Alfred-2:Workflow Data:")
set artworkFolderName to "com.calebevans.playsong"
set artworkFolderPath to (workflowDataFolder & artworkFolderName & ":")
set songArtworkNameSep to " | "

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
	global homeFolder
	
	-- recognize file paths for the icon
	if icon begins with homeFolder then
		set icon to POSIX path of icon
	end if
	
	-- escape reserved XML characters
	set title to escapeXmlChars(title)
	set subtitle to escapeXmlChars(subtitle)
	if icon is not "icon.png" then
		set icon to escapeXmlChars(icon)
	end if
	
	return tab & "<item uid='" & uid & "' arg='" & arg & "' valid='" & valid & "'>
		<title>" & title & "</title>
		<subtitle>" & subtitle & "</subtitle>
		<icon>" & icon & "</icon>
	</item>" & return & return
	
end createItem

-- create album artwork folder if it does not exist
if albumArtEnabled is true then
	tell application "Finder"
		if not (alias artworkFolderPath exists) then
			make new folder in workflowDataFolder with properties {name:artworkFolderName}
		end if
	end tell
end if

-- search iTunes library for the given query
tell application "iTunes"
	
	-- initially search songs by name
	set allSongs to (search playlist 2 for query)
	
	-- create XML string
	set xml to "<?xml version='1.0'?>" & return & "<items>" & return & return
	
	-- inform user that no results were found (prompt to switch to iTunes instead)
	if length of allSongs is 0 then
		
		set xml to xml & createItem("no-songs", "null", "no", "Not Found", ("No results for '" & query & "'"), "icon.png") of me
		
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
				
				if albumArtEnabled is false then
					set songArtworkPath to "icon.png"
				else
					-- generate a unique identifier for that album
					set songArtworkName to (songArtist & songArtworkNameSep & songAlbum) as text
					-- replace forbidden characters
					set songArtworkName to replace(":", "", songArtworkName) of me
					set songArtworkName to replace("/", "", songArtworkName) of me
					set songArtworkName to replace(".", "", songArtworkName) of me
					set songArtworkPath to (artworkFolderPath & songArtworkName & ".jpg")
					
					tell application "Finder"
						-- cache artwork if it's not already cached
						if not (songArtworkPath exists) then
							tell application "iTunes"
								-- only save artwork if artwork exists for this song
								set songArtworks to artworks of eachSong
								if (length of songArtworks) is 0 then
									set songArtworkPath to "icon.png"
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