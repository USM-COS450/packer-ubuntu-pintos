http://ask.xmodulo.com/install-minimal-ubuntu-desktop.html


$ sudo apt-get install --no-install-recommends ubuntu-desktop

$ apt-cache show ubuntu-desktop | grep "Depends"
$ apt-cache show ubuntu-desktop | grep "Recommends"

Choose a desktop
$ sudo apt-get install --no-install-recommends kubuntu-desktop
$ sudo apt-get install --no-install-recommends xubuntu-desktop
$ sudo apt-get install lubuntu-desktop
