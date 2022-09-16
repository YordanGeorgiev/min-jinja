# usage: include it in your Makefile by:
# include lib/make/tpl-gen.mk

.PHONY: tpl-gen ## @-> apply the environment cnf file into the templates
tpl-gen: demand_var-ENV demand_var-ORG demand_var-APP
	cd src/python/tpl-gen && poetry run start

.PHONY: tf-new-step ## @-> generates framework for terraform new step
tf-new-step: demand_var-ENV demand_var-ORG demand_var-APP demand_var-STEP
	./run -a do_tf_new_step

.PHONY: tf-remove-step ## @-> generates framework for terraform new step
tf-remove-step: demand_var-ENV demand_var-ORG demand_var-APP demand_var-STEP
	./run -a do_tf_remove_step