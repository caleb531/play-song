-- Play selected playlist in iTunes --

-- load workflow configuration
set config to load script POSIX file (((do shell script "pwd") as text) & "/Configuration.scpt")

-- plays songs in the given playlist
on playPlaylist(playlistName)
	global config
	
	createWorkflowPlaylist() of config
	disableShuffle() of config
	
	set playlistName to decodeXmlChars(playlistName) of config
	tell application "iTunes" to play playlist playlistName
	
end playPlaylist

playPlaylist("{query}")