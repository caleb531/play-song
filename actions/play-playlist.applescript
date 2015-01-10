-- plays selected playlist in iTunes --

-- loads workflow configuration
on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- plays songs in the given playlist
on playPlaylist(playlistId)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	tell application "iTunes"

		set thePlaylist to first user playlist whose id is playlistId
		reveal thePlaylist
		play thePlaylist

	end tell

end playPlaylist

set config to loadConfig()
playPlaylist("{query}")
