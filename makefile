#
# makefile for hello-world
#

# Make targets:
#   init                  alias for initial setup of virtual environment
#   sync                  synchronize virtual env with *requirements.txt
#   build                 create virtual environment (if required) and build
#                         executable (this is the default target (all))
#   upgrade_uv            upgrade pip and the uv package
#   upgrade_requirements  upgrade *requirements.txt files without installing
#   upgrade_venv          upgrade uv, requirements.txt and install packages


# script properties
SCRIPT_NAME := hello-world
ICON_FILE := images/python.ico

# names (directories & files)
VENV_DIR := .venv
PYTHON := "C:\Program Files\Python313\python.exe"
VENV := .\$(VENV_DIR)\Scripts
VENV_ACTIVATE := $(VENV)\activate.bat
VENV_PYTHON := $(VENV)\python.exe
UV := $(VENV)\uv.exe


all: init

.NOTPARALLEL:

init: $(VENV_ACTIVATE)

$(VENV_ACTIVATE):
	$(PYTHON) -m venv $(VENV_DIR)
	$(VENV_PYTHON) -m pip install pip --upgrade
	$(VENV_PYTHON) -m pip install uv
    ifeq (,$(wildcard requirements.txt))
		$(UV) pip compile -o requirements.txt pyproject.toml
    endif
    ifeq (,$(wildcard dev-requirements.txt))
		$(UV) pip compile --extra dev -o dev-requirements.txt pyproject.toml
    endif
	$(UV) pip sync --allow-empty-requirements dev-requirements.txt

requirements.txt: $(VENV_ACTIVATE) pyproject.toml
	$(UV) pip compile -o requirements.txt pyproject.toml

dev-requirements.txt: $(VENV_ACTIVATE) pyproject.toml
	$(UV) pip compile --extra dev -o dev-requirements.txt pyproject.toml

.PHONY: upgrade_uv
upgrade_uv: $(VENV_ACTIVATE)
	$(VENV_PYTHON) -m pip install pip --upgrade
	$(VENV_PYTHON) -m pip install uv --upgrade

.PHONY: upgrade_requirements
upgrade_requirements: $(VENV_ACTIVATE)
	$(UV) pip compile --upgrade -o requirements.txt pyproject.toml
	$(UV) pip compile --upgrade --extra dev -o dev-requirements.txt pyproject.toml

.PHONY: sync
sync: $(VENV_ACTIVATE) requirements.txt dev-requirements.txt
	$(UV) pip sync --allow-empty-requirements dev-requirements.txt

.PHONY: upgrade_venv
upgrade_venv: upgrade_uv upgrade_requirements sync

.PHONY: list
list: $(VENV_ACTIVATE)
	$(UV) pip list
