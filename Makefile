
# Basic variables
PROJECT_PATH := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
MAKEFILE_NAME := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
SHELL := /usr/bin/env bash
BUMP_TOOL := bump-my-version
DOCKER_COMPOSE ?= docker compose
AUTO_INSTALL ?=

# Colors
_SECTION := \033[1m\033[34m
_TARGET  := \033[36m
_NORMAL  := \033[0m

.DEFAULT_GOAL := help

# Project and Private variables and targets import to override variables for local
# This is to make sure, sometimes the Makefile includes don't work.
-include Makefile.variables
-include Makefile.private
## -- Informative targets ------------------------------------------------------------------------------------------- ##

.PHONY: all
all: help

# Auto documented help targets & sections from comments
#	detects lines marked by double #, then applies the corresponding target/section markup
#   target comments must be defined after their dependencies (if any)
#	section comments must have at least a double dash (-)
#
# 	Original Reference:
#		https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# 	Formats:
#		https://misc.flogisoft.com/bash/tip_colors_and_formatting
#
#	As well as influenced by it's implementation in the Weaver Project
#		https://github.com/crim-ca/weaver/tree/master

.PHONY: help
# note: use "\#\#" to escape results that would self-match in this target's search definition
help: ## print this help message (default)
	@echo ""
	@echo "Please use 'make <target>' where <target> is one of below options."
	@echo ""
	@for makefile in $(MAKEFILE_LIST); do \
        grep -E '\#\#.*$$' "$(PROJECT_PATH)/$${makefile}" | \
            awk 'BEGIN {FS = "(:|\-\-\-)+.*\#\# "}; \
            	/\--/ {printf "$(_SECTION)%s$(_NORMAL)\n", $$1;} \
				/:/  {printf "    $(_TARGET)%-24s$(_NORMAL) %s\n", $$1, $$2} ' 2>/dev/null ; \
    done

.PHONY: targets
targets: help


## -- Dev targets --------------------------------------------------------------------------------------------------- ##
.PHONY: install
install: ## Install project's dependencies
	@poetry install --with dev
	@pre-commit install

.PHONY: install-ci
install-ci: ## Install project's dependencies for github-actions
	@poetry install --with dev

.PHONY: install-package
install-package: ## Install project's package only
	@poetry install

.PHONY: fix-lint
fix-lint: ## Fix linting and formatting with pre-commit on all files
	@poetry run pre-commit run --all-files

.PHONY: local-check-links
local-check-links: ## Check links in markdown files locally using a docker image
	@$(SHELL) "$(PROJECT_PATH)/scripts/link-checker-with-docker.sh"

## -- Docs targets -------------------------------------------------------------------------------------------------- ##
.PHONY: preview-docs
preview-docs: ## Preview the documentation site locally
	@poetry run mkdocs serve


.PHONY: build-docs
build-docs: ## Build the documentation files locally
	@poetry run mkdocs build

.PHONY: deploy-docs
deploy-docs: ## Publish and deploy the documentation to the live Github page
	@echo""; \
	echo -e "\e[1;39;41m-- WARNING --\e[0m This command will deploy all current changes to the live Github page - Making it publicly available"; \
	echo""; \
	echo -n "Would you like to deploys the docs? [Y/n]: "; \
	read ans; \
	case $$ans in \
		[Yy]*) \
			echo""; \
			poetry run mkdocs gh-deploy; \
			echo""; \
			;; \
		*) \
			echo""; \
			echo "Skipping publication to Github Pages."; \
			echo " "; \
			;; \
	esac; \
