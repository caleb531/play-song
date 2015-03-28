# Play Song

*Copyright 2015 Caleb Evans*  
*Released under the MIT license*

Play Song is an [Alfred 2](http://www.alfredapp.com/) workflow designed to make
playing songs in iTunes extremely quick and convenient.

![Play Song in action](screenshot.png)

## Usage

Play Song includes five keyword filters which allow you to search for and play
songs in your iTunes library.

In order for Play Song to function properly, it requires access to assistive
devices. You can enable this for Alfred via the *Security & Privacy* pane of
System Preferences.

### Playing a song

To play an individual song, use the `playsong` keyword. Songs whose names match
your query will populate the list of results. Choosing a song from the list will
play that song once.

### Playing an album

To play all songs from a particular album, use the `playalbum` keyword. Albums
whose names match your query will populate the list of results. Choosing an
album from the list will play all songs from that album (ordered by track
number).

### Playing an artist

To play all songs by a particular artist, use the `playartist` keyword. Artists
whose names match your query will populate the list of results. Choosing a
artist from the list will play all songs by that artist (grouped by album).

### Playing a genre

To play all songs within a particular genre, use the `playgenre` keyword. Genres
whose names match your query will populate the list of results. Choosing a genre
from the list will play all songs within that genre (grouped by artist).

### Playing a playlist

To play all songs within a particular playlist, use the `playplaylist` keyword.
Non-empty playlists whose names match your query will populate the list of
results. Choosing a playlist from the list will play all songs within that
playlist (according to playlist order).

### Playing an album by a particular artist

To play an album by a particular artist, use the `playalbum` keyword. Albums
whose artist names match your query will populate the list of results. Choosing
an album from the list will play all songs from that album.

## Support

If you have a bug to report or a feature to request, please [submit an issue on
GitHub](https://github.com/caleb531/play-song/issues).

## Credits

Special thanks to [Asger Drewsen](https://github.com/Tyilo) for his invaluable
feedback and code contributions.
