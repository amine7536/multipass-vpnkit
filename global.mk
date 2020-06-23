BREW = brew

help: ## Display help
	@echo "Usage:"
	@echo "  make <target> <variables>"
	@echo ""
	@echo "Example:"
	@echo "  make vpnkit"
	@echo ""
	@echo "Targets:"
	@sed -n 's/:.*[#]#/:#/p' $(firstword $(MAKEFILE_LIST)) | sort | column -t -c 2 -s ':#' | sed 's/^/  /'
.PHONY: help

acquire-sudo:
	@sudo echo -n
.PHONY: acquire-sudo
