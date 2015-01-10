-- filters playlists by the typed query --

-- loads workflow configuration
on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

-- constructs playlist result list as XML string
on getPlaylistResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	-- search iTunes library for the given query
	tell application "iTunes"

		-- retrieve list of playlists matching query (ordered by relevance)
		set thePlaylists to {}
		set thePlaylists to thePlaylists & (get user playlists whose name starts with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)
		set thePlaylists to thePlaylists & (get user playlists whose name contains (space & query) and name does not start with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)
		set thePlaylists to thePlaylists & (get user playlists whose name contains query and name does not start with query and name does not contain (space & query) and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		-- inform user that no results were found
		if length of thePlaylists is 0 then

			addNoResultsItem(query, "playlist") of config

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

set config to loadConfig()
getPlaylistResultListXml("{query}")
