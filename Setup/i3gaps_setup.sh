#!/bin/bash

os=$(uname -u)
#Get dependencies
if [[ $os == *buntu ]]; then
	#Get ppa for libxcb-xrm-dev
	sudo add-apt-repository ppa:aguignard/ppa
	sudo apt-get update
	sudo apt-get install libxcb-xrm-dev

	#Install dependencies
	sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	autoconf libxcb-xrm-dev
fi

cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
