include ../globals.mk

vpnkit-launch-daemon: acquire-sudo ## Install vpnkit
	@sudo cp io.pixelfactory.vpnkit.plist /Library/LaunchDaemons/io.pixelfactory.vpnkit.plist
	@sudo chown root: /Library/LaunchDaemons/io.pixelfactory.vpnkit.plist
	@sudo launchctl load -w /Library/LaunchDaemons/io.pixelfactory.vpnkit.plist
.PHONY: vpnkit

install: vpnkit-launch-daemon
.PHONY: install
