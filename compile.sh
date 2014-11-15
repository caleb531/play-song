#!/bin/bash

# If compiled configuration script exists
if [ ! -f ./Configuration.scpt ]; then

	# Retrieve configuration file as plain text
	PLAINTEXT=$(cat ./Configuration.applescript)
	echo "$PLAINTEXT" | osacompile -o "./Configuration.scpt"

	echo "Compiled configuration."

else

	echo "Configuration already compiled."

fi