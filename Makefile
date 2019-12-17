SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
    $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

.DEFAULT_GOAL := help

APP=monkey

GRAY=\033[1;90m
MAGENTA=\033[1;35m
RESET_COLOR=\033[0m

## build: build the application
.PHONY: build
build: clean fmt lint
> @echo -e "${GRAY}>> ⚙️\t${MAGENTA}Building...${RESET_COLOR}"
> @go mod tidy -v
> @go build -v -trimpath .

## test: execute tests of all packages
.PHONY: test
test: lint
> @echo -e "${GRAY}>> 🧪\t${MAGENTA}Testing...${RESET_COLOR}"
> @go test -v -count=1 -race -trimpath ./...

## run: run main.go
.PHONY: run
run: build
> @echo -e "${GRAY}>> 👟\t${MAGENTA}Running...${RESET_COLOR}"
> @go run -race -trimpath main.go

## fmt: ...
.PHONY: fmt
fmt:
> @echo -e "${GRAY}>> ✏️\t${MAGENTA}Formatting...${RESET_COLOR}"
> @go fmt ./...

## lint: examine Go source code and report suspicious constructs
.PHONY: lint
lint:
> @echo -e "${GRAY}>> 🔎\t${MAGENTA}Linting...${RESET_COLOR}"
> @go vet ./...

## clean: clean the binary
.PHONY: clean
clean:
> @echo -e "${GRAY}>> 🧹\t${MAGENTA}Cleaning...${RESET_COLOR}"
> @if [ -f ${APP} ] ; then rm -v ${APP} ; fi

## mod-download: download modules to local cache
.PHONY: mod-download
mod-download:
> @echo -e "${GRAY}>> ⬇️\t${MAGENTA}Downloading modules...${RESET_COLOR}"
> @go mod download

## help: prints this help message
.PHONY: help
help:
> @echo -e "Usage: make [target] ...\n"
> @echo -e "Targets:"
> @sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
