-- filters albums by the typed query --

on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

on getAlbumResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		set theAlbums to getResultsFromQuery(query, "album") of config

		repeat with albumName in theAlbums

			set albumName to albumName as text
			set theSong to (first track of playlist 2 whose album is albumName and kind contains (songDescriptor of config))
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("album-" & albumName), arg:("album-" & albumName), valid:"yes", title:albumName, subtitle:artist of theSong, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "album") of config

		end if

	end tell

	return getResultListXml() of config

end getAlbumResultListXml

set config to loadConfig()
getAlbumResultListXml("{query}")
