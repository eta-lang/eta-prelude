PHONY: build

FILES=`find ./src -iregex '.*\.\(hs\)'`

build:
			haddock -h -o docs ${FILES}
			# mv docs/Eta.html docs/index.html

