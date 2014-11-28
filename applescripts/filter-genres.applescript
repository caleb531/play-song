---- Filters genres by the typed query ----

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs genre result list as XML string
on getGenreResultListXml(query)
	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		-- search Music playlist for songs whose genre matches query
		set theSongs to (get every track of playlist 2 whose genre contains query and kind contains (songDescriptor of config))
		set theGenres to {}
		set theIndex to 1

		-- retrieve list of genres matching query
		repeat with theSong in theSongs

			-- limit number of results
			if theIndex is greater than (resultLimit of config) then exit repeat

			-- add genre to list if not already present
			if genre of theSong is not in theGenres then
				set theGenres to theGenres & (genre of theSong)
				set theIndex to theIndex + 1
			end if

		end repeat

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theSongs is 0 then

			addResult({uid:"no-results", arg:"null", valid:"no", title:"No Genres Found", subtitle:("No genres matching '" & query & "'"), icon:defaultIconName of config}) of config

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
