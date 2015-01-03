-- filters genres by the typed query --

-- loads workflow configuration
on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- constructs genre result list as XML string
on getGenreResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		set theGenres to getResultsFromQuery(query, "genre") of config

		-- inform user that no results were found
		if length of theGenres is 0 then

			addNoResultsItem(query, "genre") of config

		else

			-- loop through the results to create the XML data
			repeat with genreName in theGenres

				set genreName to genreName as text
				set theSong to (first track of playlist 2 whose genre is genreName and kind contains (songDescriptor of config))

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("genre-" & genreName), arg:genreName, valid:"yes", title:genreName, subtitle:"Genre", icon:songArtworkPath}) of config

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getGenreResultListXml

set config to loadConfig()
getGenreResultListXml("{query}")
