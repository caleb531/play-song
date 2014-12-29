-- filters albums by the typed query --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs album result list as XML string
on getAlbumResultListXml(query)

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

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theAlbums is 0 then

			addResult({uid:"no-results", arg:"null", valid:"no", title:"No Albums Found", subtitle:("No albums matching '" & query & "'"), icon:defaultIconName of config}) of config

		else

			-- loop through the results to create the XML data
			repeat with albumName in theAlbums

				set albumName to albumName as text
				set theSong to (first track of playlist 2 whose album is albumName and kind contains (songDescriptor of config))

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("album-" & albumName), arg:albumName, valid:"yes", title:albumName, subtitle:artist of theSong, icon:songArtworkPath}) of config

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getAlbumResultListXml

createArtworkCache() of config
getAlbumResultListXml("{query}")
