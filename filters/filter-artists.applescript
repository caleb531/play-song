-- filters artists by the typed query --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs artist result list as XML string
on getArtistResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		set theArtists to getResultsFromQuery(query, "artist") of config

		-- inform user that no results were found
		if length of theArtists is 0 then

			addNoResultsItem("artist") of config

		else

			-- loop through the results to create the XML data
			repeat with artistName in theArtists

				set artistName to artistName as text
				set theSong to (first track of playlist 2 whose artist is artistName and kind contains (songDescriptor of config))

				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- add song information to XML
				addResult({uid:("artist-" & artistName), arg:artistName, valid:"yes", title:artistName, subtitle:"Artist", icon:songArtworkPath}) of config

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getArtistResultListXml

createArtworkCache() of config
getArtistResultListXml("{query}")
