-- plays selected result in iTunes --

on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

on play(query)

	global config

	clearQueue() of config
	queue(query) of config
	playQueue() of config

end play

set config to loadConfig()
play("{query}")
