-- playsongby filter --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on getArtistResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config
	set musicApplication to musicApplication of config

	tell application musicApplication

		set theArtists to getResultsFromQuery(query, "artist") of config

		repeat with artistName in theArtists

			set artistSongs to getArtistSongs(artistName) of config

			repeat with theSong in artistSongs

				if config's resultListIsFull() then exit repeat

				set songId to (get database ID of theSong)
				set songName to name of theSong
				set songArtworkPath to getSongArtworkPath(theSong) of config

				addResult({uid:("song-" & songId), valid:"yes", title:songName, subtitle:artist of theSong, icon:songArtworkPath}) of config

			end repeat

			if config's resultListIsFull() then exit repeat

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "song") of config

		end if

	end tell

	return getResultListFeedback() of config

end getArtistResultListFeedback

on run query
	set config to loadConfig()
	getArtistResultListFeedback(query as text)
end run
