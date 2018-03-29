PHONY: build

build:
			haddock -h -o docs src/Eta.hs
			mv docs/Eta.html docs/index.html

