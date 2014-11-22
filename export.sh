#!/bin/bash

# Global Alfred properties

# Path to Alfred preferences PLIST file
alfred_prefs_plist=~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist
# Path to directory in which Alfred preferences are synced
alfred_sync_dir=$(defaults read "$alfred_prefs_plist" syncfolder)
# Path to Alfred preferences
workflows=$(eval echo $alfred_sync_dir/Alfred.alfredpreferences/workflows/user.workflow.*/)
workflow_dir=""

# Workflow properties

# Name of the workflow file (w/o extension)
workflow_name="Play Song"
# Permanent bundle ID for the workflow
bundle_id="com.calebevans.playsong"

# Workflow-related paths

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

echo "Locating workflow directory..."
# Locate workflow directory from bundle ID
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
