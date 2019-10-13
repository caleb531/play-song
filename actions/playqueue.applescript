-- plays workflow queue in Music.app --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()
	playQueue() of config
end run
