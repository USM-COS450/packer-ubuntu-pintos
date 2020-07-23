# Pintos Development VM Setup for COS 450
## Fall 2018 - Ubuntu 18.04

## Overview

A packer [Packer](https://packer.io/) configuration and scripts to create a [Pintos](http://pintos-os.org) development virtual machine for USM COS 450 Operating Systems hosted in VirtualBox. The guest VM is based on Ubuntu 18.04 "Bionic Beaver" Server and includes all the packages and tools needed to complete the Pintos projects. It's stripped of most everything else to keep the image small.

**NOTE:** _host_ is the computer running VirtualBox and _guest_ is the virtualized Linux that has the Pintos development tools. You will also encounter another layer of virtualization within the guest as Pintos runs inside the guest with `bochs` or `QEMU`. It's important to understand these layers or you will get unfathomably confused.

## Building

```
make
```

Building the VM image is rather straight-forward, run `make` in the project directory. Make invokes [Packer](http://packer.io). Packer builds the image from an [Ubuntu 18.04.1 Server](http://ubuntu.org) image that then customized and stripped of extraneous services and programs. Packer.io downloads the base Ubuntu 18.04.1 `.iso` from ubuntu.org. The `pintos-dev.json` configraution determined how packer.io runs. There are a number of scripts that run as part of the process. They are located in the `packer-ubunutu-pintos` repository. They include copying and unpacking the `bochs` prebuilt binaries (above).

When building the VM the customized `bochs` v2.2.6 for Pintos (as described in the Pintos documentation) is downloaded, compiled, and installed in the `/usr/class/cos450` _course directory_. This is done to mirror the course directory setup on the USM CS Linux computers and provide a similar environment. After the custom binary is patched and built, the image is cleaned of the X11 development libraries to keep the VM image small. The course directory is added to the `pintos` users `PATH` and the provided `gdb` macros for Pintos are added to the users `.gdbinit`. This just makes things a little easier to get started.

The Packer process should generate `pintos-dev.ova` in the `dist` directory. That's it. The `.ova` file should be usable in VirtualBox, VMWare, etc.. There's also a Vagrant `box` file in `dist` if you choose to use Vagrant to manage the guest VM (see below).

## Using the Generated Virtual Machine

1. Import the generated `pintos-dev.ova` into VirtualBox or use the generated `box` file with [Vagrant](http://vagrantup.com). You should be able use any virtual machine software that imports `.ova` files without much trouble (e.g. VMWare).

2. Login to the VM as the user `pintos` with password `cos450`. If you want to `ssh` rather than use the console, note the IP address displayed just before the console login prompt.

3. Clone a copy of Pintos in the pintos home directory. For USM COS450 this will be from your generated repository on GitHub. The git url will be provided when you accept the Pintos assignment(s). _Make sure you use your git repository or you will not be able to push changes back to GitHub and your assignments will not be graded or marked as complete!_

```
git clone https://github.com/USM-COS450-F18/pintos-student.git
```

4. Start work! The first project is in the `pintos/src/threads` directory.

5. Push your changes back to GitHub so your partner can pull them and you can integrate your changes with theirs.

```
git push
```

6. When you're done, make sure you push your completed work back to GitHub, the same as you did with your intermediate changes.

## Ways to Work on Pintos with this VM

There are a number of ways you can work on Pintos. Here is a brief description of three easy to setup methods:

* You can use VirtualBox's [_Shared Folders_](https://help.ubuntu.com/community/VirtualBox/SharedFolders) feature and share a directory from your host to the guest VM. This would allow you to use your preferred editor and/or development environment. Then you can compile and run tests on the guest (on the console or via `ssh`. This is perhaps the most convienient and user-friendly setup.

* The guest has the `vim` editor installed, you can use this to edit any files on the guest VM and do all your work therein either on the console or via `ssh`. If you are familar with `vim` this is an excellent option.

* You could use another computer for editing by checking out your git repository there. You will have to `git push` on that machine, then `git pull` on the guest VM before running your tests. This could get a bit tedious but it does work.

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


## NOTES

Bochs build needs ==> virtualbox-iso: ../../cpu/../bochs.h:307:64: warning: ISO C++ forbids converting a string constant to ‘char*’ [-Wwrite-strings]

