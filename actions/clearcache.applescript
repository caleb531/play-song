-- clears workflow cache, including album artwork and compiled scripts --

on loadConfig()
	return (load script POSIX file (do shell script "bash ./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()
	try
		tell application "Finder"
			delete folder (workflowCacheFolder of config)
		end tell
		tell application "Music"
			delete user playlist (workflowPlaylistName of config)
		end tell
	end try
end run
