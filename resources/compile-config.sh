#!/bin/sh
# Compiles configuration as AppleScript

installed_config_dir="$(dirname "$0")"

# Create necessary workflow cache directories if they don't exist
cache_dir="$HOME/Library/Caches/com.runningwithcrayons.Alfred/Workflow Data/com.calebevans.playsongmm"
mkdir -p "$cache_dir"
mkdir -p "$cache_dir/Album Artwork"

# Get paths to configuration file
installed_config="$installed_config_dir/config.applescript"
compiled_config="$cache_dir/config.scpt"
cached_config_md5file="$cache_dir/config.applescript.md5"

# Retrieve md5sum of config files
installed_config_md5sum="$(md5 -q "$installed_config")"
cached_config_md5sum="$(cat "$cached_config_md5file")"

# If cached md5sum does not match installed config's md5sum
if [ ! -f "$compiled_config" ] || [ "$installed_config_md5sum" != "$cached_config_md5sum" ]; then

	# Cache installed config's md5sum
	echo "$installed_config_md5sum" > "$cached_config_md5file"
	osacompile -o "$compiled_config" "$installed_config"

fi

# Output path to compiled config file for use by workflow scripts
echo "$compiled_config"
