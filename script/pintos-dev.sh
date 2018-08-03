#!/bin/bash -eu

PINTOS_USER=${SSH_USERNAME:-pintos}
PINTOS_HOME=/home/${PINTOS_USER}

PINTOS_GIT=${PINTOS_GIT_URL:-https://github.com/USM-COS450/pintos.git}
BOCHS_BIN_TARBALL=${BOCHS_PRECOMPILED_BIN:-$PINTOS_HOME/bochs-2.2.6-bin-pintos.tar.gz}
BOCHS_SRC_URL=https://sourceforge.net/projects/bochs/files/bochs/2.2.6/bochs-2.2.6.tar.gz/download

echo "==> Install QEMU emulator"
apt-get -y install qemu-system-x86 

# For bochs
apt-get -y install libx11-6 libxpm4
if [ -f $BOCHS_BIN_TARBALL ] ; then
	echo "==> Install prebuilt Bochs emulator"
	cd /usr/local
	tar xzf $BOCHS_BIN_TARBALL --strip-components=2
	rm -f $BOCHS_BIN_TARBALL
else
	echo "==> Build and install Bochs emulator"
	apt-get -y install libx11-6-dev libxpm4-dev ncurses-dev
	cd $PINTOS_HOME
	curl -O -J -L $BOCHS_SRC_URL
	SRCDIR=$PINTOS_HOME \
		PINTOSDIR=$PINTOS_HOME/pintos \
		DSTDIR=/usr/local \
		$PINTOS_HOME/pintos/src/misc/bochs-2.2.6-build.sh
fi

echo "==> Build and install Pintos utilities"
cd $PINTOS_HOME
git clone $PINTOS_GIT
(cd pintos/src/utils && make install)
rm -rf pintos 
