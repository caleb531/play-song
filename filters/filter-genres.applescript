-- filters genres by the typed query --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

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

createArtworkCache() of config
getGenreResultListXml("{query}")
