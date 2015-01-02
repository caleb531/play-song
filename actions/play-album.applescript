-- plays selected album in iTunes --

-- loads workflow configuration
on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- plays songs belonging to the given album
on playAlbum(albumName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set albumName to decodeXmlChars(albumName) of config
	set theSongs to getAlbumSongs(albumName) of config
	playSongs(theSongs) of config

end playAlbum

set config to loadConfig()
playAlbum("{query}")
