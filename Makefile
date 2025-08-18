LOVE_FILE := last-man-in-space.love
LOVE_VERSION ?= 11.5
LINUX_URL := https://github.com/love2d/love/releases/download/$(LOVE_VERSION)/love-$(LOVE_VERSION)-linux-x86_64.tar.gz
MAC_URL := https://github.com/love2d/love/releases/download/$(LOVE_VERSION)/love-$(LOVE_VERSION)-macos.zip

love: test $(LOVE_FILE)

$(LOVE_FILE):
	zip -9 -r $(LOVE_FILE) . -x "*.git*" "$(LOVE_FILE)"

linux: $(LOVE_FILE)
	rm -rf dist/linux && mkdir -p dist/linux
	curl -L $(LINUX_URL) | tar -xz -C dist/linux --strip-components=1
	cat $(LOVE_FILE) >> dist/linux/love
	chmod +x dist/linux/love

mac: $(LOVE_FILE)
	rm -rf dist/macos && mkdir -p dist/macos
	curl -L $(MAC_URL) -o dist/love-mac.zip
	unzip -q dist/love-mac.zip -d dist/macos
	cp $(LOVE_FILE) dist/macos/love.app/Contents/Resources/

clean:
        rm -f $(LOVE_FILE)
        rm -rf dist dist/love-mac.zip

test:
	luacheck .
	python3 scripts/validate_planets.py
	busted

.PHONY: love linux mac clean test
