-- queues selected result in Music.app --

on loadConfig()
	return (load script POSIX file (do shell script "./resources/compile-config.sh"))
end loadConfig

on run query
	set config to loadConfig()
	queue(query as text) of config
end run
