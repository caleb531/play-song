-- filters albums by the typed query --

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs album result list as XML string
on getAlbumResultListXml(query)

	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		set theAlbums to getResultsFromQuery(query, "album") of config

		-- inform user that no results were found
		if length of theAlbums is 0 then

			addNoResultsItem(query, "album") of config

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
