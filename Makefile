PACKAGE_NAME=$(shell basename $(PWD))
PACKAGE_NAME_LAMBDA=$(PACKAGE_NAME)-lambda
PORT = 8080

build:
	@go build -race \
		-o go-serverless-api \
		./cmd/$(PACKAGE_NAME)

build-lambda:
	@GOOS=linux go build -race \
		-o $(PACKAGE_NAME)-lambda \
		./cmd/$(PACKAGE_NAME_LAMBDA)

bundle-lambda: build-lambda
	zip $(PACKAGE_NAME_LAMBDA).zip $(PACKAGE_NAME_LAMBDA)

run: build
	@./$(PACKAGE_NAME)

run-lambda: build-lambda
	@./$(PACKAGE_NAME_LAMBDA)


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

test-run:
	@curl http://localhost:$(PORT)/healthz
	@echo ""

.PHONY: build* run* test* bundle-lambda
