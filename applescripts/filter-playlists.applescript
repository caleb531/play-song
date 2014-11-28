---- Filters playlists by the typed query ----

-- load workflow configuration
do shell script "bash ./compile-config.sh"
set config to load script POSIX file ((do shell script "pwd") & "/config.scpt")

-- constructs playlist result list as XML string
on getPlaylistResultListXml(query)
	global config

	-- search iTunes library for the given query
	tell application "iTunes"

		set thePlaylists to (get user playlists whose name contains query and special kind is none and size is not 0 and name is not (workflowPlaylistName of config))

		-- inform user that no results were found (prompt to switch to iTunes instead)
		if length of thePlaylists is 0 then

			addResult({uid:"no-results", arg:"null", valid:"no", title:"No Playlists Found", subtitle:("No playlists matching '" & query & "'"), icon:defaultIconName of config}) of config

		else

			set theIndex to 1

			-- loop through the results to create the XML data
			repeat with thePlaylist in thePlaylists

				-- limit number of results
				if theIndex is greater than (resultLimit of config) then exit repeat

				set playlistName to name of thePlaylist
				set playlistId to id of thePlaylist

				set theSong to (first track in user playlist playlistName whose kind contains (songDescriptor of config))
				set songArtworkPath to getSongArtworkPath(theSong) of config

				-- determine number of songs in playlist
				set songCount to number of tracks in thePlaylist
				if songCount is 1 then
					set itemSubtitle to "1 song"
				else
					set itemSubtitle to (songCount & " songs") as text
				end if

				-- add song information to XML
				addResult({uid:("playlist-" & playlistId) as text, arg:playlistId as text, valid:"yes", title:playlistName, subtitle:itemSubtitle, icon:songArtworkPath}) of config

				set theIndex to theIndex + 1

			end repeat

		end if

	end tell

	return getResultListXml() of config

end getPlaylistResultListXml

createArtworkCache() of config
getPlaylistResultListXml("{query}")
