

default: dist/pintos-dev.ova

dist/pintos-dev.ova: pintos-dev.json http/preseed.cfg $(wildcard script/*.sh)
	make clean
	packer build pintos-dev.json

clean:
	-rm -rf dist
