PACKAGE_NAME=$(shell basename $(PWD))
PACKAGE_NAME_LAMBDA=$(PACKAGE_NAME)-lambda
PORT = 8080
PACKAGED_TMPL=packaged-template.yaml

bucket:
	@aws s3 mb s3://$(PACKAGE_NAME)

deploy-lambda: package-lambda
	@aws cloudformation deploy \
	    --template-file packaged-template.yaml \
	    --stack-name $(PACKAGE_NAME)-stack \
	    --capabilities CAPABILITY_IAM

delete-lambda:
	@aws cloudformation delete-stack \
	    --stack-name $(PACKAGE_NAME)-stack

package-lambda: bundle-lambda
	@aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket $(PACKAGE_NAME) \
    --output-template-file $(PACKAGED_TMPL)

bundle-lambda: build-lambda
	@zip $(PACKAGE_NAME_LAMBDA).zip $(PACKAGE_NAME_LAMBDA)

build:
	@go build -race \
		-o $(PACKAGE_NAME) \
		./cmd/$(PACKAGE_NAME)

build-lambda:
	@GOOS=linux go build -race \
		-o $(PACKAGE_NAME)-lambda \
		./cmd/$(PACKAGE_NAME_LAMBDA)

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
	@go test ./...

test-run:
	@curl http://localhost:$(PORT)/healthz
	@echo ""

.PHONY: bucket build* run* test* *-lambda
