#!/bin/bash -eu

PINTOS_USER=${SSH_USERNAME:-pintos}

PINTOS_HOME=/home/${PINTOS_USER}

echo "==> Install QEMU emulator"
# install build-essential git qemu-system-x86 ncurses-dev
apt-get -y install qemu-system-x86 
#ncurses-dev

# echo "==> Build and install Bochs emulator"
# cd $PINTOS_HOME
# curl -O -J -L  https://sourceforge.net/projects/bochs/files/bochs/2.2.6/bochs-2.2.6.tar.gz/download

# SRCDIR=$PINTOS_HOME \
# 	PINTOSDIR=$PINTOS_HOME/pintos \
# 	DSTDIR=/usr/local \
# 	$PINTOS_HOME/pintos/src/misc/bochs-2.2.6-build.sh

if [ -f /tmp/bochs-2.2.6-bin-pintos.tar.gz ] ; then
	echo "==> Install Bochs emulator"
	cd /usr/local
	tar xzf /tmp/bochs-2.2.6-bin-pintos.tar.gz --strip-components=2
fi

echo "==> Clone Pintos"
cd $PINTOS_HOME
git clone https://github.com/USM-COS450/pintos.git

echo "==> Build and install Pintos utilities"
cd pintos/src/utils && \
	make && \
	find . -executable -type f -exec cp {} /usr/local/bin \;


echo "==> Clean up Pintos and build artifacts"
#cd $PINTOS_HOME
#rm -rf pintos bochs-2.2.6.tar.gz

# apt-get -y purge ncurses-dev
# apt-get -y autoclean
# apt-get -y clean
