-- clears workflow cache, including album artwork and compiled scripts --

on loadConfig()

	set config to load script alias ((path to library folder from user domain as text) & "Caches:com.runningwithcrayons.Alfred-2:Workflow Data:com.calebevans.playsong:config.scpt")
	return config

end loadConfig

set config to loadConfig()
try
	tell application "Finder"
		delete folder (workflowCacheFolder of config)
	end tell
end try
