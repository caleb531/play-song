-- filters songs by the typed query (matching name only) --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs song result list as XML string
on getSongResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		-- search Music playlist for songs whose name matches query
		set theSongs to (get every track of playlist 2 whose name contains query and kind contains (songDescriptor of config))

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theSongs is 0 then

			addResult({uid:"no-results", arg:"null", valid:"no", title:"No Songs Found", subtitle:("No songs matching '" & query & "'"), icon:defaultIconName of config}) of config

		else

			-- loop through the results to create the XML data
			set songIndex to 1

			repeat with theSong in theSongs

				-- limit number of results
				if songIndex is greater than (resultLimit of config) then exit repeat

				-- get song information
				set songId to (get database ID of theSong)
				set songName to name of theSong
				set songArtist to artist of theSong
				set songAlbum to album of theSong
				set songKind to kind of theSong

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("song-" & songId), arg:songId as text, valid:"yes", title:songName, subtitle:songArtist, icon:songArtworkPath}) of config

				set songIndex to songIndex + 1

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getSongResultListXml

createArtworkCache() of config
getSongResultListXml("{query}")
