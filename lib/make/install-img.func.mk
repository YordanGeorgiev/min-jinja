# usage: include it in your Makefile
# include lib/make/install-img.func.mk
# call it by:
# install-web-node:
# 	$(call install-img,web-node,--no-cache,80)
# install-api-node:
# 	$(call install-img,api-node,,,linux_user)


include lib/make/demand-var.func.mk

PRODUCT := $(shell basename $$PWD)
PP_NAME := $(shell echo $$PWD|xargs dirname | xargs basename)
product := $(shell echo `basename $$PWD`|tr '[:upper:]' '[:lower:]')
DOCKER_BUILDKIT := $(or 0,$(DOCKER_BUILDKIT))

# iss-2209082055 https://pythonspeed.com/articles/docker-build-problems-mac/
define install-img
	@clear
	$(call demand-var,ORG)
	$(call demand-var,APP)
	$(call demand-var,ENV)

	$(eval NO_CACHE=${2})
	$(eval PORT_COMMAND=-p ${3}:${3})

	NO_CACHE=$(or $(2),$(2))
	PORT_COMMAND=$(or $(3),$(3))
	APPUSR=$(eval APPUSR=`echo appusr`)
	APPUSR=$(or $(4),$(APPUSR))
	$(eval PORT_COMMAND=`echo "$(PORT_COMMAND)"|perl -ne 's/-p ://g;print'`)
	

	@echo -e "\n\n START ::: running the docker build by:"
	@echo DOCKER_BUILDKIT=${DOCKER_BUILDKIT} docker build . -t ${product}-$(1)-img $(NO_CACHE) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg ORG=$(ORG) \
        --build-arg APP=$(APP) \
		--build-arg ENV=$(ENV) \
		--build-arg PP_NAME=${PP_NAME} \
		--build-arg PRODUCT=${PRODUCT} \
		-f src/docker/$(1)/Dockerfile.${PROCESSOR_ARCHITECTURE} 
	@echo -e "\n\n"
	@sleep 3
	

	DOCKER_BUILDKIT=${DOCKER_BUILDKIT} docker build . -t ${product}-$(1)-img $(NO_CACHE) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg ORG=$(ORG) \
        --build-arg APP=$(APP) \
		--build-arg ENV=$(ENV) \
		--build-arg PP_NAME=${PP_NAME} \
		--build-arg PRODUCT=${PRODUCT} \
		-f src/docker/$(1)/Dockerfile.${PROCESSOR_ARCHITECTURE}
	@echo -e "\n\n STOP  ::: running the docker build."
	@echo -e "\n\n"
	@sleep 1

	$(call uninstall-img,$1) 
	
	
	@clear
	@echo -e "\n\n START ::: spawning the docker container by:"
	@echo docker run -it -d --restart=always $(PORT_COMMAND) \
		-v $$(pwd):/${PP_NAME}/${PRODUCT} \
		-v $$HOME/.aws:/home/$(APPUSR)/.aws \
		-v $$HOME/.ssh:/home/$(APPUSR)/.ssh \
		-v $$HOME/.kube:/home/$(APPUSR)/.kube \
		--name ${product}-$(1)-con ${product}-${1}-img ;
	@echo -e "\n\n"
	@sleep 1


	DOCKER_BUILDKIT=0 docker run -it -d --restart=always $(PORT_COMMAND) \
		-v $$(pwd):/${PP_NAME}/${PRODUCT} \
		-v $$HOME/.aws:/home/${APPUSR}/.aws \
		-v $$HOME/.ssh:/home/${APPUSR}/.ssh \
		-v $$HOME/.kube:/home/${APPUSR}/.kube \
		--name ${product}-$(1)-con ${product}-${1}-img ;
	@echo -e "\nSTOP  ::: spawnning the docker container \n"


	@echo -e "to get help run: \ndocker exec -it ${product}-${1}-con ./run --help"
	@echo -e "some containers are slow to start !!! Thus, use :\n docker logs ${product}-$(1)-con"
	@echo -e "to check the container's logs "
	@echo -e "to attach run: \ndocker exec -it ${product}-${1}-con /bin/bash"
	@echo -e "\n\n"
endef


define uninstall-img
	@clear
	-@docker container stop $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
endef

