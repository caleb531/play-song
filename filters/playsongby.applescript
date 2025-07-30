-- playsongby filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getArtistResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		set theArtists to getResultsFromQuery(query, "artist") of config

		set uniqueSongIds to {}
		repeat with artistName in theArtists

			set artistSongs to getArtistSongs(artistName) of config

			repeat with theSong in artistSongs

				set songId to (get database ID of theSong)
				if songId is not in uniqueSongIds then
					set uniqueSongIds to uniqueSongIds & songId
				end if

			end repeat

		end repeat

		repeat with songId in uniqueSongIds

			if config's resultListIsFull() then exit repeat

			set theSong to getSong(songId) of config
			set songName to name of theSong
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("song-" & songId), valid:"yes", title:songName, subtitle:artist of theSong, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "song") of config

		end if

	end tell

	return getResultListFeedback(query) of config

end getArtistResultListFeedback

on run query
	set config to loadConfig()
	getArtistResultListFeedback(query as text)
end run
