LOVE_FILE := last-man-in-space.love
LOVE_VERSION ?= 11.5
LINUX_URL := https://github.com/love2d/love/releases/download/$(LOVE_VERSION)/love-$(LOVE_VERSION)-x86_64.AppImage
MAC_URL := https://github.com/love2d/love/releases/download/$(LOVE_VERSION)/love-$(LOVE_VERSION)-macos.zip
LINUX_SHA256 := 65a673406431eff7167a15a032bf7a2e4ba50108e091eb7b176465831f9b5e00
MAC_SHA256 := 6795bb3a1656af6a2fdfe741e150787b481886d3a280327a261a3fdded586913
LINUX_APPIMAGE := dist/cache/love-$(LOVE_VERSION)-x86_64.AppImage
MAC_ZIP := dist/cache/love-$(LOVE_VERSION)-macos.zip

.RECIPEPREFIX := >

love: test $(LOVE_FILE)

$(LOVE_FILE):
>zip -9 -r $(LOVE_FILE) . -x "*.git*" "$(LOVE_FILE)"

$(LINUX_APPIMAGE):
>mkdir -p dist/cache
>curl -L $(LINUX_URL) -o $@
>@echo "$(LINUX_SHA256)  $@" | sha256sum -c -
>chmod +x $@

$(MAC_ZIP):
>mkdir -p dist/cache
>curl -L $(MAC_URL) -o $@
>@echo "$(MAC_SHA256)  $@" | sha256sum -c -

linux: $(LOVE_FILE) $(LINUX_APPIMAGE)
>rm -rf dist/linux && mkdir -p dist/linux
>cp $(LINUX_APPIMAGE) dist/linux/
>cp $(LOVE_FILE) dist/linux/

mac: $(LOVE_FILE) $(MAC_ZIP)
>rm -rf dist/macos && mkdir -p dist/macos
>unzip -q $(MAC_ZIP) -d dist/macos
>cp $(LOVE_FILE) dist/macos/love.app/Contents/Resources/

clean:
>rm -f $(LOVE_FILE)
>rm -rf dist

test: $(LINUX_APPIMAGE)
>luacheck .
>python3 scripts/validate_planets.py
>busted
>@$(LINUX_APPIMAGE) scripts/benchmark_pm7.lua || echo "benchmark skipped"

.PHONY: love linux mac clean test
