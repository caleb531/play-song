-- playsong filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getSongResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		set theSongs to getResultsFromQuery(query, "name") of config
		--
		repeat with theSong in theSongs

			set songId to (get database ID of theSong)
			set songName to name of theSong
			set songArtist to artist of theSong
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("song-" & songId), valid:"yes", title:songName, subtitle:songArtist, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "song") of config

		end if

	end tell

	return getResultListFeedback(query) of config

end getSongResultListFeedback

on run query
	set config to loadConfig()
	getSongResultListFeedback(query as text)
end run
