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
		set theSongs to getResultsFromQuery(query, "name") of config

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theSongs is 0 then

			addNoResultsItem(query, "song") of config

		else

			-- loop through the results to create the XML data
			repeat with theSong in theSongs

				-- limit number of results
				if config's resultListIsFull() then exit repeat

				-- get song information
				set songId to (get database ID of theSong)
				set songName to name of theSong
				set songArtist to artist of theSong
				set songAlbum to album of theSong
				set songKind to kind of theSong

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("song-" & songId), arg:songId as text, valid:"yes", title:songName, subtitle:songArtist, icon:songArtworkPath}) of config

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getSongResultListXml

createArtworkCache() of config
getSongResultListXml("{query}")
