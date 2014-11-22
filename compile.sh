#!/bin/bash

# If compiled configuration script exists
if [ ! -f ./Configuration.scpt ]; then

	# Retrieve configuration file as plain text
	plaintext=$(cat ./Configuration.applescript)
	echo "$plaintext" | osacompile -o "./Configuration.scpt"

	echo "Compiled configuration."

else

	echo "Configuration already compiled."

fi
