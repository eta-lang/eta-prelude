PHONY: build

FILES=`find ./src -iregex '.*\.\(hs\)'`
DOCFILES=`find . -iregex '.*\.\(hs\)'`

build:
			cd src && doctest -XNoImplicitPrelude ${DOCFILES}
			haddock -h -o docs ${FILES}

