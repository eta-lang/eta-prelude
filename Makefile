.PHONY: build docs

FILES=`find ./src -iregex '.*\.\(hs\)'`
DOCFILES=`find . -iregex '.*\.\(hs\)'`


build:
	hpack
	etlas build

docs:
	cd src && doctest -XNoImplicitPrelude -W -Werror ${DOCFILES}
	haddock -h -o docs ${FILES}

