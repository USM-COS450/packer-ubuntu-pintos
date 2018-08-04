# packer-ubuntu-pintos
==============
### Overview

A packer [Packer](https://packer.io/) template to create a [Pintos](http://pintos-os.org) development environment hosted on Ubuntu 18.04 "Bionic Beaver" Server box for vagrant / VirtualBox.

### USAGE

    $ packer build pintos.json

## Vagrant

```
$ vagrant box add --name pintos-dev ./box
$ vagrant init pintos-dev
$ vagrant up
```