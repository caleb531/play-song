-- core configuration --

-- configurable options --

-- limit number of songs to improve efficiency
property resultLimit : 25
-- whether or not to retrieve/display album artwork for each result
property albumArtEnabled : true

-- workflow parameters --

property homeFolder : (path to home folder as text)
property libraryFolder : (path to library folder from user domain as text)
property cacheFolder : (libraryFolder & "Caches:")
property alfredWorkflowDataFolder : (cacheFolder & "com.runningwithcrayons.Alfred-3:Workflow Data:")
property bundleId : "com.calebevans.playsong"
property workflowCacheFolder : (alfredWorkflowDataFolder & bundleId & ":") as text
property artworkCacheFolderName : "Album Artwork"
property artworkCachePath : (workflowCacheFolder & artworkCacheFolderName & ":")
property songArtworkNameSep : " | "
property defaultIconName : "resources/icon-noartwork.png"
-- the name of the playlist used by the workflow for playing songs
property workflowPlaylistName : "Alfred Play Song"
-- the text used to determine if a track is an audio file
property songDescriptor : "audio"
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
on getResultFeedback(theResult)

	-- encode reserved JSON characters
	set resultUid to encodeFeedbackChars(uid of theResult)
	set resultValid to (valid of theResult) as text
	set resultTitle to encodeFeedbackChars(title of theResult)
	set resultSubtitle to encodeFeedbackChars(subtitle of theResult)

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
	set json to json & "\"icon\":{\"path\":\"" & resultIcon & "\"}"
	set json to json & "}"
	return json

end getResultFeedback

-- retrieves JSON document for Alfred results
on getResultListFeedback()

	set json to "{\"items\": ["

	repeat with theResult in resultList

		set json to json & getResultFeedback(theResult)
		set json to json & ","

	end repeat

	-- remove trailing comma after last item
	set json to text 1 thru (length of json - 1) of json
	set json to json & "]}"
	return json

end getResultListFeedback

-- writes the given content to the given file
on fileWrite(theFile, theContent)

	set fileRef to open for access theFile with write permission
	try
		set eof of fileRef to 0
		write theContent to fileRef starting at eof
		close access fileRef
	on error
		close access fileRef
	end try

end fileWrite

-- builds path to album art for the given song
on getSongArtworkPath(theSong)

	if albumArtEnabled is false then return defaultIconName

	tell application "iTunes"

		set songArtist to artist of theSong
		set songAlbum to album of theSong
		-- generate a unique identifier for that album
		set songArtworkName to (songArtist & songArtworkNameSep & songAlbum) as text
		-- remove forbidden path characters
		set songArtworkName to replace(":", "", songArtworkName) of me
		set songArtworkName to replace("/", "", songArtworkName) of me
		set songArtworkName to replace(".", "", songArtworkName) of me
		set songArtworkPath to (artworkCachePath & songArtworkName & ".jpg")

	end tell

	tell application "Finder"

		-- cache artwork if it's not already cached
		if not (songArtworkPath exists) then

			tell application "iTunes"

				set songArtworks to artworks of theSong
				-- only save artwork if artwork exists for this song
				if (length of songArtworks) is 0 then

					-- use default iTunes icon if song has no artwork
					set songArtworkPath to defaultIconName

				else

					-- save artwork to file
					set songArtwork to data of (item 1 of songArtworks)
					fileWrite(songArtworkPath, songArtwork) of me

				end if

			end tell

		end if

	end tell

	return songArtworkPath

end getSongArtworkPath

-- creates album artwork cache
on createWorkflowPlaylist()

	tell application "iTunes"

		if not (user playlist workflowPlaylistName exists) then

			make new user playlist with properties {name:workflowPlaylistName, shuffle:false}

		end if

	end tell

end createWorkflowPlaylist

on clearQueue()

	tell application "iTunes"

		if user playlist workflowPlaylistName exists then

			delete tracks of user playlist workflowPlaylistName

		end if

	end tell

end clearQueue

on queueSongs(theSongs)

	tell application "iTunes"

		repeat with theSong in theSongs

			duplicate theSong to user playlist workflowPlaylistName

		end repeat

	end tell

end queueSongs

on playQueue()

	tell application "iTunes"

		if number of tracks in user playlist workflowPlaylistName is not 0 then

			play user playlist workflowPlaylistName

		end if

	end tell

end playQueue

-- brings queue into view in iTunes window
on focusQueue()

	tell application "iTunes"

		reveal user playlist workflowPlaylistName

	end tell

end focusQueue

on getPlaylistSongs(playlistId)

	tell application "iTunes"

		set thePlaylist to first user playlist whose id is playlistId
		set theSongs to every track of thePlaylist

	end tell

	return theSongs

end getPlaylistSongs

-- retrieves list of artist names for the given genre
on getGenreArtists(genreName)

	tell application "iTunes"

		set theSongs to every track of playlist 2 whose genre is genreName and kind contains songDescriptor
		set artistNames to {}

		repeat with theSong in theSongs

			if (artist of theSong) is not in artistNames then

				set artistNames to artistNames & (artist of theSong)

			end if

		end repeat

	end tell

	return artistNames

end getGenreArtists

-- retrieves list of songs within the given genre, sorted by artist
on getGenreSongs(genreName)

	set artistNames to getGenreArtists(genreName) of me
	set theSongs to {}

	repeat with artistName in artistNames

		set theSongs to theSongs & getArtistSongs(artistName) of me

	end repeat

	return theSongs

end getGenreSongs

-- retrieves list of album names for the given artist
on getArtistAlbums(artistName)

	tell application "iTunes"

		set theSongs to every track of playlist 2 whose artist is artistName and kind contains songDescriptor
		set albumNames to {}

		repeat with theSong in theSongs

			if (album of theSong) is not in albumNames then

				set albumNames to albumNames & (album of theSong)

			end if

		end repeat

	end tell

	return albumNames

end getArtistAlbums

-- retrieves list of songs by the given artist, sorted by album
on getArtistSongs(artistName)

	tell application "iTunes"

		set albumNames to getArtistAlbums(artistName) of me
		set theSongs to {}

		repeat with albumName in albumNames

			set albumSongs to (every track of playlist 2 whose artist is artistName and album is albumName and kind contains songDescriptor)
			set albumSongs to sortSongsByAlbumOrder(albumSongs) of me
			set theSongs to theSongs & albumSongs

		end repeat

	end tell

	return theSongs

end getArtistSongs

-- retrieves list of songs in the given album
on getAlbumSongs(albumName)

	tell application "iTunes"

		set theSongs to every track of playlist 2 whose album is albumName and kind contains songDescriptor
		set theSongs to sortSongsByAlbumOrder(theSongs) of me

	end tell

	return theSongs

end getAlbumSongs

-- sorts songs from the same album by track number
on sortSongsByAlbumOrder(theSongs)

	tell application "iTunes"

		set theSongsSorted to theSongs

		if length of theSongs is greater than 1 then

			set trackCount to track count of (item 1 of theSongs)
			set discCount to disc count of (item 1 of theSongs)

			if trackCount is not 0 and discCount is not 0 then

				set theSongsSorted to {} as list

				repeat with discIndex from 1 to discCount

					repeat with songIndex from 1 to trackCount

						repeat with theSong in theSongs

							if disc number of theSong is discIndex and track number of theSong is songIndex then

								set nextSong to theSong
								copy nextSong to the end of theSongsSorted

							end if

						end repeat

					end repeat

				end repeat

			end if

		end if

	end tell

	return theSongsSorted

end sortSongsByAlbumOrder

-- retrieves the song with the given ID
on getSong(songId)

	tell application "iTunes"

		set theSong to first track of playlist 2 whose database ID is songId and kind contains songDescriptor

	end tell

	return theSong

end getSong

-- retrieves a list of objects or names matching the given query and type
on getResultsFromQuery(query, queryType)

	set evalScript to run script "
	script

		on findResults(query, queryType, resultLimit, songDescriptor)

			tell application \"iTunes\"

				set theSongs to (get every track in playlist 2 whose " & queryType & " starts with query and kind contains songDescriptor)

				if length of theSongs < resultLimit then

					set theSongs to theSongs & (get every track in playlist 2 whose " & queryType & " contains (space & query) and " & queryType & " does not start with query and kind contains songDescriptor)

				end if

				if length of theSongs < resultLimit then

					set theSongs to theSongs & (get every track in playlist 2 whose " & queryType & " contains query and " & queryType & " does not start with query and " & queryType & " does not contain (space & query) and kind contains songDescriptor)

				end if

				if length of theSongs < resultLimit then

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

	evalScript's findResults(query, queryType, resultLimit, songDescriptor)

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
	set theSongs to getAlbumSongs(albumName)
	queueSongs(theSongs)

end queueAlbum

-- queues all songs by the given artist
on queueArtist(artistName)

	set artistName to decodeFeedbackChars(artistName)
	set theSongs to getArtistSongs(artistName)
	queueSongs(theSongs)

end queueArtist

-- queues all songs within the given genre
on queueGenre(genreName)

	set genreName to decodeFeedbackChars(genreName)
	set theSongs to getGenreSongs(genreName)
	queueSongs(theSongs)

end queueGenre

-- queues all songs in the given playlist
on queuePlaylist(playlistId)

	set theSongs to getPlaylistSongs(playlistId)
	queueSongs(theSongs)

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
		log "Unknown type: " & theType
	end if

	focusQueue()

end queue

on play(query)

	clearQueue()
	queue(query)
	focusQueue()
	playQueue()

end play
