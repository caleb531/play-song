#!/bin/bash
# Compiles configuration as AppleScript

# Create workflow cache directory if it doesn't exist
cache_dir="$HOME/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.calebevans.playsong"
mkdir -p "$cache_dir"

# Get paths to configuration file
installed_config="config.applescript"
compiled_config="$cache_dir/config.scpt"
cached_config_md5file="$cache_dir/config.applescript.md5"

# Retrieve md5sum of config files
installed_config_md5sum=$(md5 "$installed_config" 2> /dev/null)
cached_config_md5sum=$(< "$cached_config_md5file")

# If cached md5sum does not match installed config's md5sum
if [ "$installed_config_md5sum" != "$cached_config_md5sum" ]; then

	# Cache installed config's md5sum
	echo "$installed_config_md5sum" > "$cached_config_md5file"
	osacompile -o "$compiled_config" "$installed_config"

fi
