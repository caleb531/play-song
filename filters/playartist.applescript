-- playartist filter --

on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

on getArtistResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		set theArtists to getResultsFromQuery(query, "artist") of config

		repeat with artistName in theArtists

			set artistName to artistName as text
			set theSong to (first track of playlist 2 whose artist is artistName and kind contains (songDescriptor of config))
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("artist-" & artistName), arg:("artist-" & artistName), valid:"yes", title:artistName, subtitle:"Artist", icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "artist") of config

		end if

	end tell

	return getResultListXml() of config

end getArtistResultListXml

set config to loadConfig()
getArtistResultListXml("{query}")
