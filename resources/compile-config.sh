#!/bin/bash
# Compiles configuration as AppleScript

# Change directory to one containing this file
cd "$(dirname "${BASH_SOURCE[0]}")"

installed_config_dir="."

# Create necessary workflow cache directories if they don't exist
cache_dir="$HOME/Library/Caches/com.runningwithcrayons.Alfred-3/Workflow Data/com.calebevans.playsong"
mkdir -p "$cache_dir"
mkdir -p "$cache_dir/Album Artwork"

# Get paths to configuration file
installed_config="$installed_config_dir/resources/config.applescript"
compiled_config="$cache_dir/config.scpt"
cached_config_md5file="$cache_dir/config.applescript.md5"

# Retrieve md5sum of config files
installed_config_md5sum=$(md5 -q "$installed_config")
cached_config_md5sum=$(< "$cached_config_md5file")

# If cached md5sum does not match installed config's md5sum
if [ "$installed_config_md5sum" != "$cached_config_md5sum" ]; then

	# Cache installed config's md5sum
	echo "$installed_config_md5sum" > "$cached_config_md5file"
	osacompile -o "$compiled_config" "$installed_config"

	echo "Updated config.scpt"

fi
