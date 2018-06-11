-- playartist filter --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on getArtistResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		set theArtists to getResultsFromQuery(query, "artist") of config

		repeat with artistName in theArtists

			set artistName to artistName as text
			set theSong to (first track of playlist 2 whose artist is artistName)
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("artist-" & artistName), valid:"yes", title:artistName, subtitle:genre of theSong, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "artist") of config

		end if

	end tell

	return getResultListFeedback() of config

end getArtistResultListFeedback

on run query
	set config to loadConfig()
	getArtistResultListFeedback(query as text)
end run
