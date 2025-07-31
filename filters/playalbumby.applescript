-- playalbumby filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getAlbumResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		set theArtists to getResultsFromQuery(query, "artist") of config

		set uniqueAlbums to {}
		repeat with artistName in theArtists

			set artistAlbums to getArtistAlbums(artistName) of config

			repeat with albumName in artistAlbums

				set albumName to albumName as text
				if albumName is not in uniqueAlbums then
					set uniqueAlbums to uniqueAlbums & albumName
				end if

			end repeat

		end repeat

		repeat with albumName in uniqueAlbums

			if config's resultListIsFull() then exit repeat

			set theSong to (first track of playlist 2 whose album is albumName)
			set songArtworkPath to getSongArtworkPath(theSong) of config
			
			set albumArtistValue to album artist of theSong
			if albumArtistValue is not "" then
				set subtitleValue to albumArtistValue
			else
				set subtitleValue to artist of theSong
			end if

			addResult({uid:("album-" & albumName), valid:"yes", title:albumName, subtitle:subtitleValue, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "album") of config

		end if

	end tell

	return getResultListFeedback(query) of config

end getAlbumResultListFeedback

on run query
	set config to loadConfig()
	getAlbumResultListFeedback(query as text)
end run
