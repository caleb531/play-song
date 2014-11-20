# Play Song

*Copyright 2014 Caleb Evans*  
*Released under the MIT license*

Play Song is an Alfred 2 workflow designed to make playing songs in iTunes extremely quick and convenient.

Play Song v2 is a major release, adding the ability to play not only individual songs, but albums, artists, genres, and playlists as well.

## Usage

Play Song enables five keywords which allow you to search for and play songs in your iTunes library.

In order for Play Song to function properly, it requires access to assistive devices. You can enable this for Alfred via the *Security & Privacy* pane of System Preferences.

### Playing a song

To play an individual song, use the `play` keyword. Songs which match your query will populate the list of results. Choosing a song from the list will play that song once.

Alternatively, for a more refined search, use the `playsong` keyword. Songs *whose names* match your query will populate the list of results. Choosing a song from the list will also play that song once.

### Playing an album

To play all songs from a particular album, use the `playalbum` keyword. Albums whose names match your query will populate the list of results. Choosing an album from the list will play all songs from that album (ordered by track number).

### Playing an artist

To play all songs by a particular artist, use the `playartist` keyword. Artists whose names match your query will populate the list of results. Choosing a artist from the list will play all songs by that artist (grouped by album).

### Playing a genre

To play all songs within a particular genre, use the `playgenre` keyword. Genres whose names match your query will populate the list of results. Choosing a genre from the list will play all songs within that genre (grouped by artist).

### Playing a playlist

To play all songs within a particular playlist, use the `playplaylist` keyword. Non-empty playlists whose names match your query will populate the list of results. Choosing a playlist from the list will play all songs within that playlist (according to playlist order).

## Support

If you have a bug to report or a feature to request, please [submit an issue on GitHub](https://github.com/caleb531/play-song/issues).
