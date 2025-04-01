-- plays selected song or playlist directly (the Play Song v1 behavior)
-- for songs, this behavior continues playing music after the song finishes

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()

	set typeAndId to parseResultQuery(query as text) of config
	set theType to type of typeAndId
	set theId to id of typeAndId

	tell application "Music"

		if theType is "song" then

			set theSong to getSong(theId) of config
			play theSong

		else if theType ends with "playlist" then

			set thePlaylist to getPlaylist(theId) of config
			play thePlaylist

		else

			log "Unsupported type: " & theType

		end if

	end tell
end run
