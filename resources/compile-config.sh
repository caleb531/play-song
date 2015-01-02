# Compiles configuration as AppleScript

# Create workflow cache directory if it doesn't exist
cache_dir="$HOME/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.calebevans.playsong"
mkdir -p "$cache_dir"

# Get paths to configuration file
installed_config="config.applescript"
compiled_config="$cache_dir/config.scpt"
cached_config_shafile="$cache_dir/config.applescript.shasum"

# Retrieve shasum of config files
installed_config_shasum=$(shasum "$installed_config" 2> /dev/null)
cached_config_shasum=$(< "$cached_config_shafile")

# If cached shasum does not match installed config's shasum
if [ "$installed_config_shasum" != "$cached_config_shasum" ]; then
	# Cache installed config's shasum
	echo "$installed_config_shasum" > "$cached_config_shafile"
	osacompile -o "$compiled_config" "$installed_config"

fi
