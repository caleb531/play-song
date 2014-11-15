-- Play selected artist in iTunes --

-- load workflow configuration
set config to load script POSIX file (((do shell script "pwd") as text) & "/Configuration.scpt")

-- plays all songs by the given artist
on playArtist(artistName)
	global config
	
	createWorkflowPlaylist() of config
	disableShuffle() of config
	
	set artistName to decodeXmlChars(artistName) of config
	set theSongs to getArtistSongs(artistName) of config
	playSongs(theSongs) of config
	
end playArtist

playArtist("{query}")