-- playsongin filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getAlbumResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		set theAlbums to getResultsFromQuery(query, "album") of config

		repeat with albumName in theAlbums

			set albumSongs to getAlbumSongs(albumName) of config

			repeat with theSong in albumSongs

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

	return getResultListFeedback(query) of config

end getAlbumResultListFeedback

on run query
	set config to loadConfig()
	getAlbumResultListFeedback(query as text)
end run
