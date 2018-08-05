

default: dist/pintos-dev.ova

dist/pintos-dev.ova: pintos-dev.json
	make clean
	packer build pintos-dev.json

clean:
	-rm -rf dist
