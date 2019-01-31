#!/bin/bash

izabran=0
folder=root

while [ $izabran -ne 1 ]; do
	selection=$(gdrive list -q "'$folder' in parents and trashed=false" | tail -n+2 | dmenu -l 10)
	tip=$(echo "$selection" | grep -o "dir")
	id=$(echo "$selection" | awk {'print $1'})
	if [ "$tip" = "dir" ]; then
		folder=$(echo "$id")
		continue
		
	fi
	izabran=1
	odluka=$(echo -e "No\nYes" | dmenu -p "Delete selected file?:" )
	if [ "$odluka" = "Yes" ]; then
		gdrive delete "$id"
	fi
done
