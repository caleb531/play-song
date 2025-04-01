-- playplaylist filter --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on getPlaylistResultListFeedback(query)

	global config

	set query to trimWhitespace(query) of config

	tell application "Music"

		-- retrieve list of playlists matching query (ordered by relevance)
		set thePlaylists to (get playlists whose name starts with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		if length of thePlaylists < config's resultLimit then

			set thePlaylists to thePlaylists & (get playlists whose name contains (space & query) and name does not start with query and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		end if

		if length of thePlaylists < config's resultLimit then

			set thePlaylists to thePlaylists & (get playlists whose name contains query and name does not start with query and name does not contain (space & query) and name is not config's workflowPlaylistName and special kind is none and size is not 0)

		end if

		if length of thePlaylists > config's resultLimit then

			set thePlaylists to items 1 thru (config's resultLimit) of thePlaylists

		end if

		repeat with thePlaylist in thePlaylists

			set playlistName to name of thePlaylist
			set playlistId to id of thePlaylist
			set songCount to number of tracks in thePlaylist
			set playlistDuration to time of thePlaylist

			try

				set theSong to first track in thePlaylist
				set songArtworkPath to getSongArtworkPath(theSong) of config

				set itemSubtitle to (quantifyNumber(songCount, "song", "songs") of config) & ", " & playlistDuration & " in length"

				-- Play Song does not support queueing Apple Music playlists
				-- because they can contain songs which the user has not added
				-- to their library (and such non-library songs cannot be
				-- programmatically added to a non-Apple Music playlist);
				-- therefore, we need to separate Apple Music playlists from
				-- other types of playlists
				if class of thePlaylist is subscription playlist then
					set prefixedPlaylistId to "subscription_playlist-" & playlistId
				else
					set prefixedPlaylistId to "playlist-" & playlistId
				end if
				addResult({uid:prefixedPlaylistId as text, valid:"yes", title:playlistName, subtitle:itemSubtitle, icon:songArtworkPath}) of config

			on error number -1728
			end try

		end repeat

		if config's resultListIsEmpty() then

			addNoResultsItem(query, "playlist") of config

		end if

	end tell

	return getResultListFeedback(query) of config

end getPlaylistResultListFeedback

on run query
	set config to loadConfig()
	getPlaylistResultListFeedback(query as text)
end run
