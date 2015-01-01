# Compiles configuration as AppleScript

# Create workflow cache directory if it doesn't exist
cache_dir="$HOME/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.calebevans.playsong"
mkdir -p "$cache_dir"

# Get paths to configuration file
installed_config="./config.applescript"
cached_config="$cache_dir/config.applescript"
compiled_config="$cache_dir/config.scpt"

# Retrieve contents of config files
installed_config_contents="$(cat "$installed_config" 2> /dev/null)"
cached_config_contents="$(cat "$cached_config" 2> /dev/null)"

# If cached config does not match installed config
if [ "$installed_config_contents" != "$cached_config_contents" ]; then

	# Cache installed config
	cp "$installed_config" "$cached_config"
	echo "$installed_config_contents" | osacompile -o "$compiled_config"

fi
