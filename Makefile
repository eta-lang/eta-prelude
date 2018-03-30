PHONY: build

FILES=`find ./src -iregex '.*\.\(hs\)'`

build:
			cd src && doctest Eta/Core.hs
			haddock -h -o docs ${FILES}
			# mv docs/Eta.html docs/index.html

