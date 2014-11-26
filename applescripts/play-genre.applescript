---- Plays selected genre in iTunes ----

-- load workflow configuration
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- plays all songs by the given genre
on playGenre(genreName)
	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set genreName to decodeXmlChars(genreName) of config
	set theSongs to getGenreSongs(genreName) of config
	playSongs(theSongs) of config

end playGenre

playGenre("{query}")
