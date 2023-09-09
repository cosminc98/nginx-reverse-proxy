.PHONY: setup clean

setup: clean
	./src/setup.sh

clean:
	./src/cleanup.sh