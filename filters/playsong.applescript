-- playsong filter --

on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

on getSongResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		set theSongs to getResultsFromQuery(query, "name") of config

		repeat with theSong in theSongs

			if config's resultListIsFull() then exit repeat

			set songId to (get database ID of theSong)
			set songName to name of theSong
			set songArtist to artist of theSong
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("song-" & songId), arg:("song-" & songId), valid:"yes", title:songName, subtitle:songArtist, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "song") of config

		end if

	end tell

	return getResultListXml() of config

end getSongResultListXml

set config to loadConfig()
getSongResultListXml("{query}")
