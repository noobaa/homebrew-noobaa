all: bottle
	@echo "all - done"
.PHONY: all

bottle:
	brew install --build-bottle noobaa
	brew bottle noobaa
	brew postinstall noobaa
.PHONY: bottle

