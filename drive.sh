#!/bin/sh

izabran=0
folder=root

while [ $izabran -ne 1 ]; do
	selection=$(gdrive list -q "'$folder' in parents and trashed=false" | tail -n+2 | dmenu -i -l 10)
	tip=$(echo "$selection" | grep -o "dir")
	id=$(echo "$selection" | awk '{print $1}')
	if [ "$tip" = "dir" ]; then
		folder="$id"
		continue
		
	fi
	gdrive download "$id"
	izabran=1
done
