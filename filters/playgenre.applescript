-- playgenre filter --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on getGenreResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config
	set musicApplication to musicApplication of config

	tell application musicApplication

		set theGenres to getResultsFromQuery(query, "genre") of config

		repeat with genreName in theGenres

			set genreName to genreName as text
			set theSong to (first track of playlist 2 whose genre is genreName)
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("genre-" & genreName), valid:"yes", title:genreName, subtitle:"Genre", icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "genre") of config

		end if

	end tell

	return getResultListFeedback() of config

end getGenreResultListFeedback

on run query
	set config to loadConfig()
	getGenreResultListFeedback(query as text)
end run
