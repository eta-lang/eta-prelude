PHONY: build

FILES=`find ./src -iregex '.*\.\(hs\)'`
DOCFILES=`find . -iregex '.*\.\(hs\)'`

build:
			cd src && doctest -XNoImplicitPrelude -W -Werror ${DOCFILES}
			haddock -h -o docs ${FILES}

