include global.mk

vpnkit: ## Configure vpnkit
	@$(MAKE) --directory=vpnkit install
.PHONY: vpnkit

hack: ## Install hack
	@$(MAKE) --directory=hack install
.PHONY: hack
