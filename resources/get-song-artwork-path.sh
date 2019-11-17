#!/usr/bin/env sh

# Path to the directory containing the album artwork database
ARTWORK_DB_DIR=~/Library/Containers/com.apple.AMPArtworkAgent/Data/Documents
# Path to the directory of album artwork images
ARTWORK_IMG_DIR="$ARTWORK_DB_DIR"/artwork

# The persistent ID of the song; the ID initially supplied to this script is
# formatted as a hexadecimal value (base-16), but must be converted to decimal
# (base-10) to be used in the following database query
song_persistent_id=$((0x$1))
# The path of the fallback icon to use if no image artwork is available
default_icon_path="$2"

# Retrieve the name of the album artwork image (without extension)
artwork_name=$(/usr/bin/sqlite3 \
	-list \
	-noheader \
	"$ARTWORK_DB_DIR"/artworkd.sqlite "
	select ZHASHSTRING, ZKIND from ZIMAGEINFO where Z_PK = (
		select ZIMAGEINFO from ZSOURCEINFO where Z_PK = (
			select ZSOURCEINFO from ZDATABASEITEMINFO where ZPERSISTENTID = $song_persistent_id
		)
	)" | awk '{split($0,a,"|"); print a[1] "_sk_" a[2] "_cid_1"}')

# Return the path and file extension which produces a file that exists
artwork_base_path="$ARTWORK_IMG_DIR"/"$artwork_name"
if [ -f "$artwork_base_path".jpeg ]; then
	echo "$artwork_base_path".jpeg
elif [ -f "$artwork_base_path".png ]; then
	echo "$artwork_base_path".png
else
	echo "$default_icon_path"
fi
