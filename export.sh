#!/bin/bash

# Path to Alfred preferences PLIST file
alfred_plist=~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist

# Path to directory in which Alfred preferences are synced
alfred_prefs_dir=$(defaults read "$alfred_plist" syncfolder 2> /dev/null)

# If no sync folder is set
if [[ $alfred_prefs_dir == '' ]]; then
	# Use default location for preferences
	alfred_prefs_dir="~/Library/Application Support/Alfred 2"
fi

# Installed Alfred workflows
workflows=$(eval echo "$alfred_prefs_dir"/Alfred.alfredpreferences/workflows/user.workflow.*/)

# Directory for installed workflow
workflow_dir=""

# Name of the workflow file (w/o extension)
workflow_name="Play Song"

# Permanent bundle ID for the workflow
bundle_id="com.calebevans.playsong"

# Path to project repository
project_dir=$(dirname $0)

# Path to plain-text workflow configuration
project_config="$project_dir/Configuration.applescript"

# Path to script used for compiling configuration
project_config_compile="$project_dir/compile.sh"

# Path to zip file used to create workflow file
workflow_zip_file="$project_dir/$workflow_name.zip"

# Path to resulting workflow file
workflow_file="$project_dir/$workflow_name.alfredworkflow"

# Locate workflow directory from bundle ID
echo "Locating workflow directory..."
for workflow in $workflows
do
	# If workflow PLIST lists the bundle ID
	if plutil -extract bundleid xml1 "$workflow/info.plist" -o - | grep "$bundle_id" &> /dev/null; then
		workflow_dir="$workflow"
		break
	fi
done

# If workflow directory exists
if [ ! -d "$workflow_dir" ]; then
	# Stop script here
	echo "Workflow directory could not be found."
	exit 1
fi

# Copy over latest workflow configuration
echo "Updating configuration..."
cp $project_config $workflow_dir
# Copy over latest configuration compilation script
echo "Updating configuration compiler..."
cp $project_config_compile $workflow_dir

# Zip all workflow files except compiled configuration
echo "Zipping workflow files..."
zip -rj "$workflow_zip_file" "$workflow_dir"* -x *Configuration.scpt

# Convert zip file to workflow file
echo "Converting zip file to workflow..."
mv "$workflow_zip_file" "$workflow_file"

echo "Workflow successfully exported."
