.PHONY: do-tpl-gen ## @-> apply the environment cnf file into the templates on the tpl-gen container
do-tpl-gen: demand_var-ORG demand_var-ENV demand_var-APP
	docker exec -e APP=$(APP) -e ENV=$(ENV) -e ORG=$(ORG) ${PRODUCT}-tpl-gen-con make tpl-gen

# eof file: src/make/local-setup-tasks.incl.mk
