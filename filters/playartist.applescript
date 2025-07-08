-- playartist filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getArtistResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		set theArtists to getResultsFromQuery(query, "artist") of config

		repeat with artistName in theArtists

			set artistName to artistName as text
			-- Try to find a song with this artist name in any of the three fields
			try
				set theSong to (first track of playlist 2 whose artist is artistName)
			on error number -1728
				try
					set theSong to (first track of playlist 2 whose composer is artistName)
				on error number -1728
					try
						set theSong to (first track of playlist 2 whose album artist is artistName)
					on error number -1728
						-- Skip this artist if no matching song is found
						exit repeat
					end try
				end try
			end try
			
			set songArtworkPath to getSongArtworkPath(theSong) of config

			addResult({uid:("artist-" & artistName), valid:"yes", title:artistName, subtitle:genre of theSong, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "artist") of config

		end if

	end tell

	return getResultListFeedback(query) of config

end getArtistResultListFeedback

on run query
	set config to loadConfig()
	getArtistResultListFeedback(query as text)
end run
