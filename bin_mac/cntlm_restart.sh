#/bin/bash


echo "Stopping cntlm"
sudo launchctl unload /Library/LaunchDaemons/de.db.cntlm.plist

echo "Waiting"
sleep 3;

echo "Starting cntlm"
sudo launchctl load /Library/LaunchDaemons/de.db.cntlm.plist

echo "Done!"
