-- Play selected album in iTunes --

-- load workflow configuration
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- plays songs belonging to the given album
on playAlbum(albumName)
	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set albumName to decodeXmlChars(albumName) of config
	set theSongs to getAlbumSongs(albumName) of config
	playSongs(theSongs) of config

end playAlbum

playAlbum("{query}")
