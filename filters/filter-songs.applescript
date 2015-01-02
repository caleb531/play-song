-- filters songs by the typed query --

-- loads workflow configuration
on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- constructs song result list as XML string
on getSongResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		set theSongs to getResultsFromQuery(query, "name") of config

		-- inform user that no results were found
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

set config to loadConfig()
createArtworkCache() of config
getSongResultListXml("{query}")
