SHELL := /bin/bash

.PHONY: all help init build install upload smoke-test install-deps init-submodules download-models

# Always run `hf` via pipx to avoid relying on local `hf` installations.
hf := pipx run --spec "huggingface_hub[cli]" hf

# TODO: Replace with snap name
SNAP_NAME ?= nemotron-3-5-super-vl 

ENGINE ?= cpu

all: help

#
# Main targets
#

help: ## Show this help message
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@# List all targets with descriptions (lines starting with '##'):
	@grep -E '^[a-zA-Z0-9_-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-11s %s\n", $$1, $$2}'

init: init-submodules install-deps download-models ## Initialize the build environment (dependencies, model weights, submodules, etc.)

build: ## Build the snap
	./dev/build.sh

install: ## Install the snap
	./dev/install.sh

upload: ## Upload the snap
	./dev/upload.sh

smoke-test: ## Run smoke tests (override with SNAP_NAME=... ENGINE=...)
	sudo ./dev/smoke-test.sh $(SNAP_NAME) $(ENGINE)

#
# Supporting targets
#

install-deps:
	@echo "Installing dependencies..."
	@# Ensure pipx is available for running the hf CLI.
	@command -v pipx >/dev/null 2>&1 || { \
		sudo apt-get update; \
		sudo apt-get install -y pipx; \
	}

init-submodules:
	@echo "Initializing submodules..."
	@if git submodule status | grep -q '^-'; then \
		git submodule update --init; \
	fi

download-models: download-model-Q4_K_XL download-mmproj-BF16

download-model-Q4_K_XL:
	@echo "Downloading Nemotron 3.5 Super VL Q4_K_XL model weights..."
	$(hf) download inference-snaps/Nemotron-3.5-Super-VL --include "NVIDIA-Nemotron-3.5-Super-VL-120B-A12B-Q4_K_XL-*-of-00020.gguf" \
		--local-dir model-weights/Q4_K_XL/

download-mmproj-BF16:
	@echo "Downloading Nemotron 3.5 Super VL mmproj-BF16 model weights..."
	$(hf) download unsloth/NVIDIA-Nemotron-3.5-Super-VL-120B-A12B-GGUF mmproj-BF16.gguf \
		--local-dir model-weights/mmproj-BF16/
