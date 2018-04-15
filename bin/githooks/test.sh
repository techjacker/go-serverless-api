#!/bin/bash

####################
# go get github.com/ChimeraCoder/gojson/gojson
####################
go test ./...

# check for race conditions
go test -race ./...
# go run -race ./cmd/diffence/main.go -config ./test/fixtures/config.json
