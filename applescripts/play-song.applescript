-- Play selected song in iTunes --

-- load workflow configuration
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- plays the song with the given ID
on playSong(songId)
	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	try
		set songId to songId as integer
		set theSong to getSong(songId) of config
		playSongs({theSong}) of config
	end try

end playSong

playSong("{query}")
