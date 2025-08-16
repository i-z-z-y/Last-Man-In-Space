LOVE_FILE := last-man-in-space.love

love: $(LOVE_FILE)

$(LOVE_FILE):
	zip -9 -r $(LOVE_FILE) . -x "*.git*" "$(LOVE_FILE)"

clean:
	rm -f $(LOVE_FILE)

.PHONY: love clean
