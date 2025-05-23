-- core configuration --

-- configurable options --

-- limit number of songs to improve efficiency
property resultLimit : 90
-- whether or not to retrieve/display album artwork for each result
property albumArtEnabled : true

-- workflow parameters --

-- workflow folders
property libraryFolder : (path to library folder from user domain as text)
property cacheFolder : (libraryFolder & "Caches:")
property alfredWorkflowDataFolder : (cacheFolder & "com.runningwithcrayons.Alfred:Workflow Data:")
property bundleId : "com.calebevans.playsongmm"
property workflowCacheFolder : (alfredWorkflowDataFolder & bundleId & ":") as text

-- the default icon used for search results without album artwork
property defaultIconName : "resources/icon-noartwork.png"
-- the name of the playlist used by the workflow for playing songs
property workflowPlaylistName : "Alfred Play Song"
-- list of Alfred results
property resultList : {}

-- replaces substring in string with another substring
on replace(replaceThis, replaceWith, theString)

	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to replaceThis
	set strItems to text items of theString
	set AppleScript's text item delimiters to replaceWith
	set newString to strItems as text
	set AppleScript's text item delimiters to oldDelims
	return newString

end replace

-- retrieve the plural/singular form of a quantity based on the given number
on quantifyNumber(theNumber, quantityName, pluralQuantityName)

	if theNumber is 1 then

		set theString to (theNumber as text) & space & quantityName

	else

		set theString to (theNumber as text) & space & pluralQuantityName

	end if

	return theString

end quantifyNumber

-- encodes JSON reserved characters in the given string
on encodeFeedbackChars(theString)

	set theString to replace("\\", "\\\\", theString)
	set theString to replace("\"", "\\\"", theString)
	return theString

end encodeFeedbackChars

-- decodes JSON reserved characters in the given string
on decodeFeedbackChars(theString)

	set theString to replace("\\\\", "\\", theString)
	set theString to replace("\\\"", "\"", theString)
	return theString

end decodeFeedbackChars

-- adds Alfred result to result list
on addResult(theResult)

	copy theResult to the end of resultList

end addResult

-- adds item for "No Results" message
on addNoResultsItem(query, queryType)

	addResult({uid:"no-results", valid:"no", title:"No Results Found", subtitle:("No " & queryType & "s matching '" & query & "'"), icon:defaultIconName})

end addNoResultsItem

on resultListIsFull()

	return (length of resultList is resultLimit)

end resultListIsFull

on resultListIsEmpty()

	return (length of resultList is 0)

end resultListIsFull

-- builds Alfred result item as JSON
on getResultFeedback(theResult, query)

	-- encode reserved JSON characters
	set resultUid to encodeFeedbackChars(uid of theResult)
	set resultValid to (valid of theResult) as text
	set resultTitle to encodeFeedbackChars(title of theResult)
	set resultSubtitle to encodeFeedbackChars(subtitle of theResult)
	set typeAndId to parseResultQuery(resultUid)
	set resultType to type of typeAndId
	set resultId to id of typeAndId

	if (icon of theResult) contains ":" then

		set resultIcon to encodeFeedbackChars(POSIX path of icon of theResult)

	else

		set resultIcon to icon of theResult

	end if

	set json to "{"
	set json to json & "\"uid\":\"" & resultUid & "\","
	set json to json & "\"arg\":\"" & resultUid & "\","
	set json to json & "\"valid\":\"" & resultValid & "\","
	set json to json & "\"title\":\"" & resultTitle & "\","
	set json to json & "\"subtitle\":\"" & resultSubtitle & "\","
	set json to json & "\"text\":{"
	set json to json & "\"copy\":\"" & resultTitle & "\","
	set json to json & "\"largetype\":\"" & resultTitle & "\""
	set json to json & "},"
	set json to json & "\"variables\":{"
	if resultType is "playlist" or resultType is "subscription_playlist" then
		set json to json & "\"action\":\"play_directly\""
	else
		set json to json & "\"action\":\"play\""
	end if
	set json to json & "},"
	set json to json & "\"mods\":{"
	set json to json & "\"cmd\":{"
	if resultType is "subscription_playlist" then
		set json to json & "\"subtitle\":\"Queueing Apple Music playlists is not supported at this time\","
		set json to json & "\"valid\":\"no\","
	else
		set json to json & "\"subtitle\":\"Queue " & resultType & "\","
	end if
	set json to json & "\"variables\":{"
	set json to json & "\"action\":\"queue\""
	set json to json & "}"
	set json to json & "},"
	if resultType is "song" then
		set json to json & "\"shift\":{"
		set json to json & "\"subtitle\":\"Play" & space & resultType & space & "directly (the v1 behavior)\","
		set json to json & "\"variables\":{"
		set json to json & "\"action\":\"play_directly\""
		set json to json & "}"
		set json to json & "},"
	end if
	set json to json & "\"ctrl\":{"
	set json to json & "\"subtitle\":\"Search on web\","
	set json to json & "\"variables\":{"
	set json to json & "\"action\":\"search_on_web\","
	if resultType is "artist" or resultType is "genre" then
		set json to json & "\"search_query\":\"" & resultTitle & "\""
	else if resultUid is "no-results" then
		set json to json & "\"search_query\":\"" & query & "\""
	else
		set json to json & "\"search_query\":\"" & resultTitle & space & "-" & space & resultSubtitle & "\""
	end if
	set json to json & "}"
	set json to json & "}"
	set json to json & "},"
	set json to json & "\"icon\":{\"path\":\"" & resultIcon & "\"}"
	set json to json & "}"
	return json

end getResultFeedback

-- retrieves JSON document for Alfred results
on getResultListFeedback(query)

	set json to "{\"items\": ["

	repeat with theResult in resultList

		set json to json & getResultFeedback(theResult, query)
		set json to json & ","

	end repeat

	-- remove trailing comma after last item
	if last character of json is "," then set json to text 1 thru (length of json - 1) of json
	set json to json & "]}"
	return json

end getResultListFeedback

-- query path to artwork image file cached natively by Music.app in Catalina
on getSongArtworkPath(theSong)

	try

		if albumArtEnabled is false then return defaultIconName

		tell application "Music"

			-- get persistent ID of song and use it to fetch album artwork
			set songId to persistent ID of theSong
			-- the base path to the artwork file (without extension)
			set artworkPath to (do shell script "sh ./resources/get-song-artwork-path.sh" & space & songId & space & defaultIconName)

		end tell

		return artworkPath

	on error errorMessage

		log errorMessage

	end try

end getSongArtworkPath

-- creates album artwork cache
on createWorkflowPlaylist()

	tell application "Music"

		if not (user playlist workflowPlaylistName exists) then

			make new user playlist with properties {name:workflowPlaylistName, shuffle:false}

		end if

	end tell

end createWorkflowPlaylist

on clearQueue()

	tell application "Music"

		if user playlist workflowPlaylistName exists then

			delete tracks of user playlist workflowPlaylistName

		end if

	end tell

end clearQueue

on queueSongs(theSongs)

	tell application "Music"

		repeat with theSong in theSongs

			duplicate theSong to user playlist workflowPlaylistName

		end repeat

	end tell

end queueSongs

on playQueue()

	tell application "Music"

		if number of tracks in user playlist workflowPlaylistName is not 0 then

			play user playlist workflowPlaylistName

		end if

	end tell

end playQueue

on getPlaylist(playlistId)

	tell application "Music"

		return (first playlist whose id is playlistId)

	end tell

end getPlaylist

on getPlaylistSongs(playlistId)

	tell application "Music"

		set thePlaylist to getPlaylist(playlistId) of me
		set playlistSongs to every track of thePlaylist

	end tell

	return playlistSongs

end getPlaylistSongs

-- retrieves list of songs within the given genre, sorted by artist
on getGenreSongs(genreName)

	tell application "Music"

		set genreSongs to every track of playlist 2 whose genre is genreName

	end tell

	return genreSongs

end getGenreSongs

-- retrieves list of album names for the given artist
on getArtistAlbums(artistName)

	tell application "Music"

		-- Get songs where any of the three fields match
		set artistSongs to every track of playlist 2 whose artist is artistName or composer is artistName or album artist is artistName
		set albumNames to {}

		repeat with theSong in artistSongs
			if (album of theSong) is not in albumNames then
				set albumNames to albumNames & (album of theSong)
			end if
		end repeat
	end tell

	return albumNames

end getArtistAlbums

-- retrieves list of songs by the given artist, sorted by album
on getArtistSongs(artistName)

	tell application "Music"

		-- Get songs where any of the three fields match
		set artistSongs to every track of playlist 2 whose artist is artistName or composer is artistName or album artist is artistName

	end tell

	return artistSongs

end getArtistSongs

-- retrieves list of songs in the given album
on getAlbumSongs(albumName)

	tell application "Music"

		set albumSongs to every track of playlist 2 whose album is albumName

	end tell

	return albumSongs

end getAlbumSongs

-- retrieves the song with the given ID
on getSong(songId)

	tell application "Music"

		set theSong to first track of playlist 2 whose database ID is songId

	end tell

	return theSong

end getSong

-- retrieves a list of objects or names matching the given query and type
on getResultsFromQuery(query, queryType)

	-- Special handling for artist queries to search across multiple fields
	if queryType is "artist" then
		set evalScript to run script "
		script
			on findResults(query, resultLimit)
				tell application \"Music\"
					-- First, get tracks where any of the three fields start with query
					set theSongs to (get every track in playlist 2 whose artist starts with query)
					set theSongs to theSongs & (get every track in playlist 2 whose composer starts with query)
					set theSongs to theSongs & (get every track in playlist 2 whose album artist starts with query)

					if length of theSongs < resultLimit then
						-- Then, get tracks where any of the three fields contain the query with a space before it
						set theSongs to theSongs & (get every track in playlist 2 whose artist contains (space & query) and artist does not start with query)
						set theSongs to theSongs & (get every track in playlist 2 whose composer contains (space & query) and composer does not start with query)
						set theSongs to theSongs & (get every track in playlist 2 whose album artist contains (space & query) and album artist does not start with query)
					end if

					if length of theSongs < resultLimit then
						-- Finally, get tracks where any of the three fields contain the query anywhere
						set theSongs to theSongs & (get every track in playlist 2 whose artist contains query and artist does not start with query and artist does not contain (space & query))
						set theSongs to theSongs & (get every track in playlist 2 whose composer contains query and composer does not start with query and composer does not contain (space & query))
						set theSongs to theSongs & (get every track in playlist 2 whose album artist contains query and album artist does not start with query and album artist does not contain (space & query))
					end if

					if length of theSongs is 0 then
						-- Use search as a fallback
						set theSongs to theSongs & (search playlist 2 for query only artists)
					end if

					-- Extract unique artist, composer, and album artist values
					set theResults to {}

					repeat with theSong in theSongs
						if length of theResults is resultLimit then exit repeat

						-- Check artist field
						set artistValue to artist of theSong
						if artistValue is not in theResults and artistValue is not \"\" then
							set theResults to theResults & artistValue
						end if

						-- Check composer field
						set composerValue to composer of theSong
						if composerValue is not in theResults and composerValue is not \"\" then
							set theResults to theResults & composerValue
						end if

						-- Check album artist field
						set albumArtistValue to album artist of theSong
						if albumArtistValue is not in theResults and albumArtistValue is not \"\" then
							set theResults to theResults & albumArtistValue
						end if
					end repeat
				end tell

				return theResults
			end findResults
		end script
		"

		return evalScript's findResults(query, resultLimit)
	else
		-- Original implementation for other query types
		set evalScript to run script "
		script
			on findResults(query, queryType, resultLimit)

				tell application \"Music\"

					set theSongs to (get every track in playlist 2 whose " & queryType & " starts with query)

					if length of theSongs < resultLimit then

						set theSongs to theSongs & (get every track in playlist 2 whose " & queryType & " contains (space & query) and " & queryType & " does not start with query)

					end if

					if length of theSongs < resultLimit then

						set theSongs to theSongs & (get every track in playlist 2 whose " & queryType & " contains query and " & queryType & " does not start with query and " & queryType & " does not contain (space & query))

					end if

					if length of theSongs is 0 then

						if queryType is \"name\" then

							set theSongs to theSongs & (search playlist 2 for query only songs)

						else if queryType is not \"genre\" then

							set theSongs to theSongs & (search playlist 2 for query only " & queryType & "s)

						end if

					end if

					if queryType is \"name\" then

						if length of theSongs > resultLimit then

							set theSongs to items 1 thru resultLimit of theSongs

						end if

						set theResults to theSongs

					else

						set theResults to {}

						repeat with theSong in theSongs

							if length of theResults is resultLimit then exit repeat

							set theResult to " & queryType & " of theSong

							if theResult is not in theResults then

								set theResults to theResults & theResult

							end if

						end repeat

					end if

				end tell

				return theResults

			end findResults

		end script
		"

		return evalScript's findResults(query, queryType, resultLimit)

	end if

end getResultsFromQuery

-- returns the given string with leading and trailing whitespace removed
on trimWhitespace(theString)

	-- trim leading whitespace
	repeat while theString begins with space

		if length of theString is 1 then return ""
		set theString to text 2 thru end of theString

	end repeat

	-- trim trailing whitespace
	repeat while theString ends with space

		set theString to text 1 thru ((length of theString) - 1) of theString

	end repeat

	return theString

end trimWhitespace

-- queues the song with the given ID
on queueSong(songId)

	set theSong to getSong(songId)
	queueSongs({theSong})

end queueSong

-- queues all songs belonging to the given album
on queueAlbum(albumName)

	set albumName to decodeFeedbackChars(albumName)
	set albumSongs to getAlbumSongs(albumName)
	queueSongs(albumSongs)

end queueAlbum

-- queues all songs by the given artist
on queueArtist(artistName)

	set artistName to decodeFeedbackChars(artistName)
	set artistSongs to getArtistSongs(artistName)
	queueSongs(artistSongs)

end queueArtist

-- queues all songs within the given genre
on queueGenre(genreName)

	set genreName to decodeFeedbackChars(genreName)
	set genreSongs to getGenreSongs(genreName)
	queueSongs(genreSongs)

end queueGenre

-- queues all songs in the given playlist
on queuePlaylist(playlistId)

	set playlistSongs to getPlaylistSongs(playlistId)
	queueSongs(playlistSongs)

end queuePlaylist

-- parses the given result query to retrieve type and id of item to queue
on parseResultQuery(query)

	set pos to offset of "-" in query
	set theType to text 1 thru (pos - 1) of query
	set theId to text (pos + 1) thru end of query
	return {type:theType, id:theId}

end parseResultQuery

on queue(query)

	set typeAndId to parseResultQuery(query)
	set theType to type of typeAndId
	set theId to id of typeAndId

	createWorkflowPlaylist()

	if theType is "song" then
		queueSong(theId)
	else if theType is "album" then
		queueAlbum(theId)
	else if theType is "artist" then
		queueArtist(theId)
	else if theType is "genre" then
		queueGenre(theId)
	else if theType is "playlist" then
		queuePlaylist(theId)
	else
		log "Unsupported type: " & theType
	end if

end queue

on play(query)

	clearQueue()
	queue(query)
	playQueue()

end play
