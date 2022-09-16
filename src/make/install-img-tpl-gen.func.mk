# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

SHELL = bash
PRODUCT := $(shell basename $$PWD)
product:= $(shell echo `basename $$PWD`|tr '[:upper:]' '[:lower:]')

ORG := $(shell export ORG=$${ORG}; echo $${ORG})
APP := $(shell export APP=$${APP}; echo $${APP})
ENV := $(shell export ENV=$${ENV}; echo $${ENV})


TPL_GEN_PORT=



.PHONY: clean-install-tpl-gen  ## @-> setup the whole local tpl-gen environment for python no cache
clean-install-tpl-gen:
	$(call install-img,tpl-gen,--no-cache,${TPL_GEN_PORT})

.PHONY: install-tpl-gen  ## @-> setup the whole local tpl-gen environment for python
install-tpl-gen:
	$(call install-img,tpl-gen,,${TPL_GEN_PORT})
