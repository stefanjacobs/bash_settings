#/bin/bash


echo "Stopping cntlm"
sudo launchctl unload /Library/LaunchDaemons/de.db.cntlm.plist
sudo launchctl remove /Library/LaunchDaemons/de.db.cntlm.plist

echo "Done!"
