[![Build Status](https://travis-ci.org/techjacker/go-serverless-api.svg?branch=master)](https://travis-ci.org/techjacker/go-serverless-api)
[![Go Report Card](https://goreportcard.com/badge/github.com/techjacker/go-serverless-api)](https://goreportcard.com/report/github.com/techjacker/go-serverless-api)

# go-serverless-api
- Boilerplate Golang API
- AWS Severless Application Model (SAM) Deployment to AWS Lambda & API Gateway


-----------------------------------------------------------
## Deploy to AWS

Deploy to AWS Lambda & API Gateway with AWS Serverless Application Model (SAM).

```shell
$ aws s3 mb s3://go-serverless-api

$ aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket go-serverless-api \
    --output-template-file packaged-template.yaml

$ aws cloudformation deploy \
    --template-file packaged-template.yaml \
    --stack-name go-serverless-api-stack \
    --capabilities CAPABILITY_IAM

$ aws cloudformation describe-stacks \
    --stack-name go-serverless-api-stack
```


Destroy Stack
```shell
@aws cloudformation delete-stack \
	--stack-name go-serverless-api-stack
```



-----------------------------	------------------------------
## Local Development
#### Build & Run API
```shell
$ make run
```

#### Manually call APi
```shell
$ make test-run
```

-----------------------------------------------------------
## Tests
```
$ go test ./...
```
