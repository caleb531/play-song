-- filters playlists by the typed query --

on loadConfig()

	do shell script "./compile-config.sh"
	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

on getPlaylistResultListXml(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "iTunes"

		-- retrieve list of playlists matching query (ordered by relevance)
		set thePlaylists to (get user playlists whose name starts with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		if length of thePlaylists < config's resultLimit then

			set thePlaylists to thePlaylists & (get user playlists whose name contains (space & query) and name does not start with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		end if

		if length of thePlaylists < config's resultLimit then

			set thePlaylists to thePlaylists & (get user playlists whose name contains query and name does not start with query and name does not contain (space & query) and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		end if

		if length of thePlaylists > config's resultLimit then

			set thePlaylists to items 1 thru (config's resultLimit) of thePlaylists

		end if

		repeat with thePlaylist in thePlaylists

			set playlistName to name of thePlaylist
			set playlistId to id of thePlaylist
			set songCount to number of tracks in thePlaylist

			set theSong to (first track in user playlist playlistName whose kind contains (songDescriptor of config))
			set songArtworkPath to getSongArtworkPath(theSong) of config

			if songCount is 1 then

				set itemSubtitle to "1 song"

			else

				set itemSubtitle to (songCount & " songs") as text

			end if

			addResult({uid:("playlist-" & playlistId) as text, arg:("playlist-" & playlistId) as text, valid:"yes", title:playlistName, subtitle:itemSubtitle, icon:songArtworkPath}) of config

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "playlist") of config

		end if

	end tell

	return getResultListXml() of config

end getPlaylistResultListXml

set config to loadConfig()
getPlaylistResultListXml("{query}")
