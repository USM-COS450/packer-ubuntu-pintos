# Pintos Development VM Setup for COS 450
## Fall 2018 Version
==============

## Overview

A packer [Packer](https://packer.io/) template to create a [Pintos](http://pintos-os.org) development environment hosted on Ubuntu 18.04 "Bionic Beaver" Server box for vagrant / VirtualBox.

## Tools

* [Packer.io](http://packer.io) to script the creation of a `.ova` VM image. While the image is really tuned to VirtualBox, it should work with other virtualization systems (VMWare).

* [VirtualBox](http://virtualbox.org) for running the Linux VM machine that in turn runs the Pintos compiler, debugger, and emulators (QEMU and customized bochs).

## Building

Prior to making the VM image, the customized `bochs` v2.2.6 needs to be built and installed in `/usr/local`. Then `/usr/local` is cleaned up (of extra files) and tarred into an unpackaple archive `bochs-bin-pintos-2.6.2.tar.gz` and placed in the `packer-ubuntu-pintos` directory for later inclusion in the VM image. This prebuilding avoids installing XWindows development libraries on the final Pintos development image, keeping size down.

```
# Development dependencies for bochs
apt-get -y install libx11-6-dev libxpm4-dev ncurses-dev

# Fetch bochs source
curl -O -J -L https://sourceforge.net/projects/bochs/files/bochs/2.2.6/bochs-2.2.6.tar.gz/download

# Fetch pintos source (with bochs patches and build script)
git clone https://github.com/USM-COS450/pintos.git

# Build and install bochs in /usr/local
sudo SRCDIR=/home/pintos \
    PINTOSDIR=/home/pintos/pintos \
    DSTDIR=/usr/local \
    home/pintos/pintos/src/misc/bochs-2.2.6-build.sh

# Not entirely correct, misses the cleanup part and that the extraction
# strips the starting path, but close for now.
(cd /usr/local; tar czvf /home/pintos/bochs-2.2.6-bin-pintos.tar.gz ./*)
```

Building the VM image is rather straight-forward. Packer.io starts with an [Ubuntu 18.04.1 Server](http://ubuntu.org) image that gets stripped down of extraneous services and programs. Packer.io builds the image starting with an original fetched `.iso` from ubuntu.org. The `pintos.json` configraution determined how packer.io runs. There are a number of scripts that run as part of the process. They are located in the `packer-ubunutu-pintos` repository. They include copying and unpacking the `bochs` prebuilt binaries (above).

```
packer build pintos-dev.json
```

This all should generate `ubuntu-pintos.ova` in the `packer-ubuntu-pintos` directory.
That's it. The `.ova` file should be usable in VirtualBox, VMWare, etc..

## Vagrant (for running the box)

```
$ vagrant box add --name pintos-dev ./box
$ vagrant init pintos-dev
$ vagrant up
```