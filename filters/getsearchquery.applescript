-- get search query for Google search --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()
	set typeAndId to parseResultQuery(query as text) of config
	set theType to type of typeAndId
	set theId to id of typeAndId
	if theType is "song" then
		tell application "iTunes"
			set theSong to getSong(theId) of config
			set songName to name of theSong
			set songArtist to artist of theSong
			return songName & " by " & songArtist
		end tell
	else
		return theId
	end if
end run
