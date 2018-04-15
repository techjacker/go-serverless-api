#!/bin/bash

####################
# https://github.com/mvdan/interfacer/
# go get -u github.com/mvdan/interfacer/cmd/interfacer
####################

OUT=$(interfacer $(go list ./... | grep -v /vendor/))

if [[ ! -z $OUT ]]; then
	echo "$OUT"
	exit 1
fi
