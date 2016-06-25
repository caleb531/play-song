-- clears workflow queue in iTunes --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()
	clearQueue() of config
end run
