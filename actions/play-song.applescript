-- plays selected song in iTunes --

-- loads workflow configuration
on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- plays the song with the given ID
on playSong(songId)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set theSong to getSong(songId) of config
	playSongs({theSong}) of config

end playSong

set config to loadConfig()
playSong("{query}")
