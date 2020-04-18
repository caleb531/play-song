-- enables the global Shuffle Mode in the Music app --

on run query
	tell application "Music"
		set shuffle enabled to true
		return (get shuffle enabled as string)
	end tell
end run
