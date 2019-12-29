.PHONE: all install

CURRENT_REVISION = $(shell git rev-parse --short HEAD)
CURRENT_VERSION = $(shell cat version)
TEST_VERSION = "v${CURRENT_VERSION}-${CURRENT_REVISION}"

all: install

build-ubuntu-18.04: ## Build an image with Ubuntu 18.04 ready to install
	docker build \
		--build-arg branch=${CURRENT_REVISION} \
		--no-cache \
		-t pedromss/dotfiles-ubuntu18.04:${TEST_VERSION} \
		-f docker/ubuntu-18.04/Dockerfile \
		docker/ubuntu-18.04

run-ubuntu-18.04: ## Run the image built by 'build-ubuntu-18.04'
	docker run \
		--rm \
		-it \
		--name dotfiles \
		pedromss/dotfiles-ubuntu18.04:${TEST_VERSION} \
		bash

ubuntu1804: build-ubuntu-18.04 run-ubuntu-18.04

install: ## Run the install script as sudo and accepting all prompts
	sudo ./install.sh -y

install-dev: ## All tools related to software development
	@sudo ./install.sh -y \
		-t go \
		-t rust \
		-t nvm \
		-t sdkman \
		-t gradle \
		-t docker \
		-t python-pip \
		-t python-pip3 \
		-t kubectl

install-sh: ## Essential tools for a good shell experience
	@sudo ./install.sh -y \
		-t rust \
		-t zsh \
		-t tmux \
		-t vim \
		-t shellcheck \
		-t fzf \
		-t exa \
		-t bat \
		-t python-pip \
		-t python-pip3 \
		-t ctags \
		-t docker \
		-t kubectl \
		-t tpm \
		-t ag

# From https://github.com/zplug/zplug/blob/master/Makefile
help: 
	@grep -E '^[a-zA-Z0-9\._-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}'
