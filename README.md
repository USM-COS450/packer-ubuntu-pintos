# Pintos Development VM Setup for COS 450
## Fall 2018 Version -- Ubuntu 18.04
==============

## Overview

A packer [Packer](https://packer.io/) configuration and scripts to create a [Pintos](http://pintos-os.org) development virtual machine for USM COS 450 Operating Systems hosted in VirtualBox. The guest VM is based on Ubuntu 18.04 "Bionic Beaver" Server and includes all the packages and tools needed to complete the Pintos projects. It's stripped of most everything else to keep the image small.

## Using the Generated Virtual Machine

1. Import the generated `pintos-dev.ova` into VirtualBox or use the generated `box` file with [Vagrant](http://vagrantup.com).

2. Login to the VM as the user `pintos` with password `cos450`.

3. Clone a copy of Pintos in the pintos home directory. For USM COS450 this will be from your generated repository on GitHub. The git url will be provided when you "accept" the Pintos assignment(s). _Make sure you use your git repository or you will not be able to push changes back to GitHub and your assignments will not be graded or marked as complete!_

```
git clone https://github.com/USM-COS450-F18/pintos-student.git
```

4. Start work! The first project is in the `pintos/src/threads` directory.

5. Push your changes back to GitHub so your partner can pull them and you can integrate your changes with theirs.

```
git push
```

6. When you're done, make sure you push your completed work back to GitHub, the same as you did with your intermediate changes.

## Building

When building the VM the customized `bochs` v2.2.6 for Pintos (as described in the Pintos documentation) is downloaded, compiled, and installed in the `/usr/class/cos450` _course directory_. This is done to mirror the _course directory_ setup on the USM CS Linux computers and provide a similar environment. After the custom binary is patched and built, the image is cleaned of the X11 development libraries to keep the VM image small.

Building the VM image is rather straight-forward, run `make` in the project directory. Make invokes [Packer](http://packer.io). Packer builds the image from an [Ubuntu 18.04.1 Server](http://ubuntu.org) image that then customized and stripped of extraneous services and programs. Packer.io downloads the base Ubuntu 18.04.1 `.iso` from ubuntu.org. The `pintos-dev.json` configraution determined how packer.io runs. There are a number of scripts that run as part of the process. They are located in the `packer-ubunutu-pintos` repository. They include copying and unpacking the `bochs` prebuilt binaries (above).

This all should generate `pintos-dev.ova` in the `dist` directory. That's it. The `.ova` file should be usable in VirtualBox, VMWare, etc.. There's also a Vagrant `box` file in `dist` if you choose to use Vagrant to manage the guest VM (see below).

## Tools Used

* [Packer.io](http://packer.io) to script the creation of a `.ova` VM image. While the image is really tuned to VirtualBox, it should work with other virtualization systems (VMWare).

* [VirtualBox](http://virtualbox.org) for running the Linux VM machine that in turn runs the Pintos compiler, debugger, and emulators (QEMU and customized bochs).

* [Vagrant](http://vagrantup.com) alternate for running the Linux VM from the command line instead of a GUI. Still uses VirtualBox under the covers, though you can make it use VMWare if you buy the adapter.

## Vagrant (for running the box)

Something like this might work if you are using Vagrant rather than VirtualBox. VirtualBox might be more user-friendly, so venture here only if you are curious and brave. I've not tested this!

```
$ vagrant box add --name pintos-dev ./box
$ vagrant init pintos-dev
$ vagrant up
```