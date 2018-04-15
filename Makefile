PORT = 8000

build:
	@go build -race .

run: build
	@./$(shell basename $(PWD))

# https://github.com/dominikh/go-tools/
lint:
	@golint  -set_exit_status ./...
	@go vet ./...
	@interfacer $(go list ./... | grep -v /vendor/)
	@gosimple ./...
	@staticcheck ./...
	@unused ./...

test:
	@go test

test-cover:
	@go test -cover

test-race:
	@go test -race

test-run:
	@curl http://localhost:$(PORT)/healthz
	@echo ""

.PHONY: test* lint install build
