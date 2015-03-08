-- filters albums by the typed query --

-- loads workflow configuration
on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- constructs album result list as XML string
on getAlbumResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	-- search iTunes library for the given query
	tell application "iTunes"
		set theArtists to getResultsFromQuery(query, "artist") of config
		
		set empty to true
		
		repeat with artistName in theArtists
			set artistName to artistName as text
			
			set artistAlbums to getArtistAlbums(artistName) of config

			repeat with albumName in artistAlbums
				if resultListIsFull() of config then
					exit repeat
				end if
				
				set albumName to albumName as text
				set theSong to (first track of playlist 2 whose album is albumName and kind contains (songDescriptor of config))

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("album-" & albumName), arg:("album-" & albumName), valid:"yes", title:albumName, subtitle:artist of theSong, icon:songArtworkPath}) of config
				
				set empty to false
			end repeat

			if resultListIsFull() of config then
				exit repeat
			end if
		end repeat

		-- inform user that no results were found
		if empty then

			addNoResultsItem(query, "album") of config

		end if

	end tell

	return getResultListXml() of config

end getAlbumResultListXml

set config to loadConfig()
getAlbumResultListXml("{query}")
