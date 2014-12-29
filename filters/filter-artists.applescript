-- filters artists by the typed query --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs artist result list as XML string
on getArtistResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		-- search Music playlist for songs whose artist matches query
		set theSongs to (get every track of playlist 2 whose artist contains query and kind contains (songDescriptor of config))
		set theArtists to {}
		set theIndex to 1

		-- retrieve list of artists matching query
		repeat with theSong in theSongs

			-- limit number of results
			if theIndex is greater than (resultLimit of config) then exit repeat

			-- add artist to list if not already present
			if artist of theSong is not in theArtists then

				set theArtists to theArtists & (artist of theSong)
				set theIndex to theIndex + 1

			end if

		end repeat

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of theSongs is 0 then

			addResult({uid:"no-results", arg:"null", valid:"no", title:"No Artists Found", subtitle:("No artists matching '" & query & "'"), icon:defaultIconName of config}) of config

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
