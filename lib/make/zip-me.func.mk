# # usage: include it in your Makefile
# include <<file-path>>
#
# usage:
# make zip_me
# 


.ONESHELL: # Applies to every targets in the file!

.PHONY: zip_me ## @-> zip the whole project without the .git dir
zip_me:
	@clear
	clear ; rm -v ../$(basename `pwd`).zip ; zip -r ../$(basename `pwd`).zip . -symlinks -x '.git/*' -x '*/.terraform/*' -x '*/.venv/*'
	@sleep 1
	@clear
	@echo done check
	@echo $(PWD)/../$(PRODUCT).zip
