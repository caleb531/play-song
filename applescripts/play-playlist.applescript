---- Plays selected playlist in iTunes ----

-- load workflow configuration
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- plays songs in the given playlist
on playPlaylist(playlistId)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	tell application "iTunes"

		set thePlaylist to first user playlist whose id is playlistId
		play thePlaylist

	end tell

end playPlaylist

playPlaylist("{query}")
