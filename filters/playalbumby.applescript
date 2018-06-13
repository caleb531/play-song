-- playalbumby filter --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on getAlbumResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		set theArtists to getResultsFromQuery(query, "artist") of config

		repeat with artistName in theArtists

			set artistAlbums to getArtistAlbums(artistName) of config

			repeat with albumName in artistAlbums

				if config's resultListIsFull() then exit repeat

				set albumName to albumName as text
				set theSong to (first track of playlist 2 whose album is albumName)
				set songArtworkPath to getSongArtworkPath(theSong) of config

				addResult({uid:("album-" & albumName), valid:"yes", title:albumName, subtitle:artist of theSong, icon:songArtworkPath}) of config

			end repeat

			if config's resultListIsFull() then exit repeat

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "album") of config

		end if

	end tell

	return getResultListFeedback() of config

end getAlbumResultListFeedback

on run query
	set config to loadConfig()
	getAlbumResultListFeedback(query as text)
end run
