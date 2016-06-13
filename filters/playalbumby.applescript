-- playalbumby filter --

on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-3:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

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
				set theSong to (first track of playlist 2 whose album is albumName and kind contains (songDescriptor of config))
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
