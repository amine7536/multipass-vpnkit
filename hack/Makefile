include ../global.mk
hyperkit=/Library/Application\ Support/com.canonical.multipass/bin/hyperkit

brew:
	@$(BREW) reinstall --cask multipass
.PHONY: brew

define install_hack
if file ${hyperkit} | grep -q 'Mach-O.*executable'; then
	mv ${hyperkit} ${hyperkit}.original
	cp hyperkit.sh ${hyperkit}
	chmod +x ${hyperkit}
fi
endef
export install_hack

hack: acquire-sudo
	@sudo bash -c "eval \"$$install_hack\""
.PHONY: hack

install: brew hack
