# PHONY are targets with no files to check, all in our case
.DEFAULT_GOAL := help

PACKAGE_NAME=pmeshlab
IMAGE_SANDBOX=cadic/$(PACKAGE_NAME):sandbox
IMAGE_VANILLA=cadic/$(PACKAGE_NAME):vanilla
SRV=/srv
FILESTORE=/FileStore

# Makefile for launching common tasks
DOCKER_OPTS ?= \
    -e DISPLAY=${DISPLAY} \
	-v /dev/shm:/dev/shm \
	-v $(HOME)/.ssh:/home/foo/.ssh \
	-v $(HOME)/.config:/home/foo/.config \
	-v $(PWD):/workspace \
	-v $(SRV):/srv \
	-v $(FILESTORE):/FileStore \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /var/run/docker.sock:/var/run/docker.sock \
	--network=host \
	--privileged

VERSION=$(shell python -c 'from $(PACKAGE_NAME) import __version__;print(__version__)')

# Ensure that we have a configuration file
$(conf_file):
	$(error Please create a '$(conf_file)' file first, for example by copying example_conf.env. No '$(conf_file)' found)

help:
	@echo "Usage: make {build,  bash, ...}"
	@echo "Please check README.md for instructions"
	@echo ""


# BUILD:
build: build_wheels build_dockers

# BUILD DOCKER
build_dockers: build_docker_vanilla build_docker_sandbox 

build_docker_vanilla:
	docker build . -t  $(IMAGE_VANILLA) --network host -f docker/vanilla/Dockerfile
	docker tag $(IMAGE_VANILLA) $(IMAGE_VANILLA)_$(VERSION)

build_docker_sandbox:
	docker build . -t  $(IMAGE_SANDBOX) --network host -f docker/sandbox/Dockerfile
	docker tag $(IMAGE_SANDBOX) $(IMAGE_SANDBOX)_$(VERSION)

# BUILD WHEEL
build_wheels: build_wheel

build_wheel:
	# Build the wheels
	@mv dist/*.whl dist/legacy/ || true
	@pip wheel . -w ./dist
	@mv dist/${PACKAGE_NAME}*.whl ./ && rm dist/*.whl && mv ${PACKAGE_NAME}*.whl dist/
	@clean || true

# PUSH
push_dockers: push_docker_vanilla push_docker_sandbox

push_docker_sandbox:
	@docker tag $(IMAGE_SANDBOX) $(IMAGE_SANDBOX)-$(PACKAGE_NAME)_$(VERSION)
	docker push $(IMAGE_SANDBOX)
	docker push $(IMAGE_SANDBOX)-$(PACKAGE_NAME)_$(VERSION)

push_docker_vanilla:
	@docker tag $(IMAGE_VANILLA) $(IMAGE_VANILLA)-$(PACKAGE_NAME)_$(VERSION)
	docker push $(IMAGE_VANILLA)
	docker push $(IMAGE_VANILLA)-$(PACKAGE_NAME)_$(VERSION)

# PULL
pull_dockers: pull_docker_vanilla pull_docker_sandbox

pull_docker_vanilla:
	docker pull $(IMAGE_VANILLA)

pull_docker_sandbox:
	docker pull $(IMAGE_SANDBOX)

# DOCKER RUNs
docker_run_sandbox_cpu:
	@docker stop dev_$(PACKAGE_NAME)_sandbox || true
	@docker rm dev_$(PACKAGE_NAME)_sandbox || true
	docker run --name dev_$(PACKAGE_NAME)_sandbox ${DOCKER_OPTS} -dt $(IMAGE_SANDBOX)
	docker exec -it dev_$(PACKAGE_NAME)_sandbox bash

docker_run_sandbox_gpu:
	@docker stop dev_$(PACKAGE_NAME)_sandbox || true
	@docker rm dev_$(PACKAGE_NAME)_sandbox || true
	@docker run --name dev_$(PACKAGE_NAME)_sandbox ${DOCKER_OPTS} --gpus all -dt $(IMAGE_SANDBOX)
	docker exec -it dev_$(PACKAGE_NAME)_sandbox bash

# COMMON
clean:
	@find . -name "*.pyc" | xargs rm -f && \
		find . -name "__pycache__" | xargs rm -rf

checkout:
	# Update git
	@git checkout -b $(VERSION)_auto || true; \
		git add .; git commit -m $(VERSION)_auto; \
		git push origin $(VERSION)_auto

install_wheels:
	pip install dist/deps/*.whl; pip install dist/*.whl

tests:
	docker run -i  $(IMAGE_SANDBOX) python -m ai3ddst.tests

# ALL
all: build checkout push_dockers
all_branch: build_wheels checkout
