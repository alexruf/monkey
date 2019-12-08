.DEFAULT_GOAL := help

APP=monkey

GRAY=\033[1;90m
MAGENTA=\033[1;35m
RESET_COLOR=\033[0m

.PHONY: build
## build: build the application
build: clean fmt lint
	@echo "${GRAY}>> ⚙️\t${MAGENTA}Building...${RESET_COLOR}"
	@go mod tidy -v
	@go build -v -trimpath .

.PHONY: test
## test: execute tests of all packages
test: lint
	@echo "${GRAY}>> 🧪\t${MAGENTA}Testing...${RESET_COLOR}"
	@go test -v -count=1 -race -trimpath ./...

.PHONY: run
## run: run main.go
run: build
	@echo "${GRAY}>> 👟\t${MAGENTA}Running...${RESET_COLOR}"
	@go run -race -trimpath main.go

.PHONY: fmt
## fmt: ...
fmt:
	@echo "${GRAY}>> ✏️\t${MAGENTA}Formatting...${RESET_COLOR}"
	@go fmt ./...

.PHONY: lint
## lint: examine Go source code and report suspicious constructs
lint:
	@echo "${GRAY}>> 🔎\t${MAGENTA}Linting...${RESET_COLOR}"
	@go vet ./...

.PHONY: clean
## clean: clean the binary
clean:
	@echo "${GRAY}>> 🧹\t${MAGENTA}Cleaning...${RESET_COLOR}"
	@if [ -f ${APP} ] ; then rm -v ${APP} ; fi

.PHONY: mod-download
## mod-download: download modules to local cache
mod-download:
	@echo "${GRAY}>> ⬇️\t${MAGENTA}Downloading modules...${RESET_COLOR}"
	@go mod download

.PHONY: help
## help: prints this help message
help:
	@echo "Usage: make [target] ...\n"
	@echo "Targets:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
