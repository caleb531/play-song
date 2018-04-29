# Play Song

*Copyright 2013-2018 Caleb Evans*  
*Released under the MIT license*

Play Song is an [Alfred](http://www.alfredapp.com/) workflow designed to make
playing music in iTunes extremely quick and convenient.

The workflow will be solely supporting Alfred 3 going forward, but the latest
Alfred 2-compatible release (v3.3.1) will remain available here for your
convenience.

![Play Song in action](screenshot.png)

## Usage

Play Song includes a number of keyword filters which allow you to search for and
play songs in your iTunes library.

### Playing a song

To play an individual song, use the `playsong` keyword. Songs whose names match
your query will populate the list of results. Choosing a song from the list will
play that song once.

### Playing a song in a particular album

To play a song in a particular album, use the `playsongin` keyword. Songs whose
album names match your query will populate the list of results. Choosing a song
from the list will play that song once.

### Playing an album

To play all songs from a particular album, use the `playalbum` keyword. Albums
whose names match your query will populate the list of results. Choosing an
album from the list will play all songs from that album.

#### Playing an album by a particular artist

To play an album by a particular artist, use the `playalbum` keyword. Albums
whose artist names match your query will populate the list of results. Choosing
an album from the list will play all songs from that album.

### Playing an artist

To play all songs by a particular artist, use the `playartist` keyword. Artists
whose names match your query will populate the list of results. Choosing a
artist from the list will play all songs by that artist.

### Playing a genre

To play all songs within a particular genre, use the `playgenre` keyword. Genres
whose names match your query will populate the list of results. Choosing a genre
from the list will play all songs within that genre.

### Playing a playlist

To play all songs within a particular playlist, use the `playplaylist` keyword.
Non-empty playlists whose names match your query will populate the list of
results. Choosing a playlist from the list will play all songs within that
playlist.

### Queueing songs

For any of the above filters, choosing a result with the `cmd` key held down
will queue the result (as opposed to playing it immediately). This allows you to
queue up multiple songs before playing them.

To play the songs you've queued, use the `playqueue` keyword. To clear the queue
of all songs, use the `clearqueue` keyword.

## Searching songs on Google

For any of the above filters, choosing a result with the `ctrl` key held down
will search the result on Google.

### Clearing the cache

Play Song stores a local cache containing album artwork (from displayed
results), as well as the compiled workflow configuration. If you experience any
issues with Play Song, you can clear this cache via the `clearcache` keyword.

### A note about play order

Play Song always respects the current shuffle mode within iTunes. For example,
if shuffle is enabled, playing an album via Play Song will play the songs of the
album in shuffled order. Therefore, if you desire Play Song to respect album
order, simply disable shuffle within iTunes.

### Playing a song directly (the Play Song v1 behavior)

If you are a longtime Play Song user who prefers the v1 behavior for playing
songs (where music continues playing after the song finishes), you can do so via
the `shift` modifier. Note that this only works for the `playsong` filter.

## Support

If you have a bug to report or a feature to request, please [submit an issue on
GitHub](https://github.com/caleb531/play-song/issues).

## Credits

Special thanks to [Asger Drewsen](https://github.com/Tyilo) for his invaluable
feedback and code contributions.
