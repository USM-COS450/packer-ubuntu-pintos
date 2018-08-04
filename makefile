

default: dist/pintos-dev.ova

dist/pintos-dev.ova: pintos-dev.json
	make clean
	packer build pintos-dev.json

clean:
	-rm -rf box
	-rm -rf output-pintos-dev-virtualbox-iso