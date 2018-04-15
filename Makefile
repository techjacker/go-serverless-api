PORT = 8000

build:
	@go build -race -o go-serverless-api ./cmd/go-serverless-api

build-lambda:
	@GOOS=linux go build -race -o go-serverless-api-lambda ./cmd/go-serverless-api-lambda

run: build
	@./$(shell basename $(PWD))

run-lambda: build-lambda
	@./$(shell basename $(PWD))-lambda


# https://github.com/dominikh/go-tools/
lint:
	@golint -set_exit_status $(go list ./... | grep -v /vendor/)
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
