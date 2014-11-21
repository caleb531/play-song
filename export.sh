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
workflow_name="Play Song"
bundle_id="com.calebevans.playsong"

# Workflow-related paths
project_dir=$(dirname $0)
project_config="$project_dir/Configuration.applescript"
project_config_compile="$project_dir/compile.sh"
workflow_zip_file="$project_dir/$workflow_name.zip"
workflow_file="$project_dir/$workflow_name.alfredworkflow"

echo "Locating workflow directory..."
# Locate workflow directory from bundle ID
for workflow in $workflows
do
	if plutil -extract bundleid xml1 "$workflow/info.plist" -o - | grep "$bundle_id" &> /dev/null; then
		workflow_dir="$workflow"
		break
	fi
done

# If workflow directory exists
if [ ! -d "$workflow_dir" ]; then
	echo "Workflow directory could not be found."
	exit 1
fi

# Copy latest configuration to workflow folder
echo "Updating configuration..."
cp $project_config $workflow_dir
echo "Updating configuration compiler..."
cp $project_config_compile $workflow_dir

# Zip workflow files
echo "Zipping workflow files..."
zip -rj "$workflow_zip_file" "$workflow_dir"* -x *Configuration.scpt

# Convert zip file to workflow file
echo "Converting zip file to workflow..."
mv "$workflow_zip_file" "$workflow_file"

echo "Done."
