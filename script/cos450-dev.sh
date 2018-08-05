#!/bin/bash -eu

COS450_HOME=${COS450_HOME:-/usr/local}
PINTOS_GIT=${PINTOS_GIT_URL:-https://github.com/USM-COS450/pintos.git}

BOCHS_SRC_URL=https://sourceforge.net/projects/bochs/files/bochs/2.2.6/bochs-2.2.6.tar.gz/download

SSH_USER=${SSH_USERNAME:-pintos}

# Make sure we are in the COS450 directory to do the setup
mkdir -p ${COS450_HOME}
cd ${COS450_HOME}

echo "==> Build and install Pintos utilities"
git clone $PINTOS_GIT ./pintos
(cd pintos/src/utils && make DSTDIR=${COS450_HOME} install )

echo "==> Install QEMU emulator"
# Also install dependencies to build bochs
apt-get -y install qemu-system-x86 xorg-dev ncurses-dev

# These need to stick around for bochs to run.
#apt-get -y install libx11-6 libxpm4 

echo "==> Build and install Bochs emulator"
curl -L $BOCHS_SRC_URL bochs-2.2.6.tar.gz
SRCDIR=$COS450_HOME \
	PINTOSDIR=$COS450_HOME/pintos \
	DSTDIR=${COS450_HOME} \
	$COS450_HOME/pintos/src/misc/bochs-2.2.6-build.sh

echo "==> Update ${SSH_USER}'s path and GDB configuration"
# Add COS450/Pintos tools to path
cat >> $SSH_USER_HOME/.profile << !EOF

if [ -d $COS450_HOME ] ; then
	PATH="$COS450_HOME/bin:$PATH"
fi
!EOF

cat >> $SSH_USER_HOME/.gdbinit << !EOF
source /usr/class/cos450/bin/gdb-macros

# dump a Pintos Ready list
define dumpready
  dumplist &ready_list thread elem
end

define dumpall
  dumplist &ready_list thread elem
end
!EOF

echo "==> Remove staging Pintos and bochs source"
rm -rf pintos 
rm -rf bochs-2.2.6.tar.gz man share/doc

