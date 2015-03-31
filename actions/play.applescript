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

-- plays all songs belonging to the given album
on playAlbum(albumName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set albumName to decodeXmlChars(albumName) of config
	set theSongs to getAlbumSongs(albumName) of config
	playSongs(theSongs) of config

end playAlbum

-- plays all songs by the given artist
on playArtist(artistName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set artistName to decodeXmlChars(artistName) of config
	set theSongs to getArtistSongs(artistName) of config
	playSongs(theSongs) of config

end playArtist

-- plays all songs within the given genre
on playGenre(genreName)

	global config

	createWorkflowPlaylist() of config
	disableShuffle() of config

	set genreName to decodeXmlChars(genreName) of config
	set theSongs to getGenreSongs(genreName) of config
	playSongs(theSongs) of config

end playGenre

-- plays all songs in the given playlist
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

-- parses the given query to retrieve type and id of item to play
on parseQuery(query)

	set pos to offset of "-" in query
	set theType to text 1 thru (pos - 1) of query
	set theId to text (pos + 1) thru end of query
	return {type:theType, id:theId}

end parseQuery

--
on play(query)

	set typeAndId to parseQuery(query)
	set theType to type of typeAndId
	set theId to id of typeAndId

	if theType is "song" then
		playSong(theId)
	else if theType is "album" then
		playAlbum(theId)
	else if theType is "artist" then
		playArtist(theId)
	else if theType is "genre" then
		playGenre(theId)
	else if theType is "playlist" then
		playPlaylist(theId)
	else
		log "Unknown type: " & theType
	end if

end play

set config to loadConfig()
play("{query}")
