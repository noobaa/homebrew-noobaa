all: bottle
	@echo "all - done"
.PHONY: all

bottle:
	brew uninstall noobaa || true
	brew install --build-bottle noobaa
	brew bottle noobaa
	brew postinstall noobaa
.PHONY: bottle

