## Compiles configuration as AppleScript

# If compiled configuration script exists
if [ ! -f ./config.scpt ]; then

	# Retrieve configuration file as plain text
	plaintext=$(cat ./config.applescript)
	echo "$plaintext" | osacompile -o "./config.scpt"

	echo "Compiled configuration."

else

	echo "Configuration already compiled."

fi
