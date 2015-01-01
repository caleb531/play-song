-- plays selected artist in iTunes --

-- loads workflow configuration
on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- plays all songs by the given artist
on playArtist(artistName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set artistName to decodeXmlChars(artistName) of config
	set theSongs to getArtistSongs(artistName) of config
	playSongs(theSongs) of config

end playArtist

set config to loadConfig()
playArtist("{query}")
