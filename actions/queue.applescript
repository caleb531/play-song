-- queues selected result in iTunes --

on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-3:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

set config to loadConfig()
queue("{query}") of config
