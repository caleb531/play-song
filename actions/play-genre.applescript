-- plays selected genre in iTunes --

-- loads workflow configuration
on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- plays all songs by the given genre
on playGenre(genreName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set genreName to decodeXmlChars(genreName) of config
	set theSongs to getGenreSongs(genreName) of config
	playSongs(theSongs) of config

end playGenre

set config to loadConfig()
playGenre("{query}")
