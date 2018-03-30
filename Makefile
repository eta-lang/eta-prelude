PHONY: build

FILES=`find ./src -iregex '.*\.\(hs\)'`

build:
			cd src && doctest Eta/Prelude/Core.hs
			haddock -h -o docs ${FILES}
			# mv docs/Eta.html docs/index.html

