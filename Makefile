INTERFACE_FILES = $(notdir $(wildcard interfaces/*.conf))
INTERFACES = $(basename $(INTERFACE_FILES))
SERVICE_FILES = $(addsuffix .plist, $(addprefix wg-quick., $(INTERFACES)))

SCRIPT_TARGETS = /usr/local/sbin/wg-quick-service
INTERFACE_TARGETS = $(addprefix /usr/local/etc/wireguard/, $(INTERFACE_FILES))
SERVICE_TARGETS = $(addprefix /Library/LaunchDaemons/, $(SERVICE_FILES))
TARGETS = $(SCRIPT_TARGETS) $(INTERFACE_TARGETS) $(SERVICE_TARGETS)


.PHONY: install clean

install: $(TARGETS)
	@:

clean:
	rm -f $(TARGETS)

/usr/local/etc/wireguard/%.conf: interfaces/%.conf
	install -m 0700 -d /usr/local/etc/wireguard
	install -m 0600 $< $@

/usr/local/sbin/wg-quick-service: sbin/wg-quick-service
	install $< $@

/Library/LaunchDaemons/wg-quick.%.plist: services/wg-quick.plist.in interfaces/%.conf
	sed 's/{NAME}/$*/g' services/wg-quick.plist.in > $@
	launchctl load $@
