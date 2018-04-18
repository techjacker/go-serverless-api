[![Build Status](https://travis-ci.org/techjacker/go-serverless-api.svg?branch=master)](https://travis-ci.org/techjacker/go-serverless-api)
[![Go Report Card](https://goreportcard.com/badge/github.com/techjacker/go-serverless-api)](https://goreportcard.com/report/github.com/techjacker/go-serverless-api)

# go-serverless-api
- Boilerplate Golang API
- AWS Severless Application Model (SAM) Deployment to AWS Lambda & API Gateway


-----------------------------------------------------------
## Deploy to AWS

#### 1. Build and package into a zip
```Shell
$ make bundle-lambda
```

#### 2. Upload zip to AWS S3 & create updated SAM template (`packaged-template.yaml`)
```shell
$ aws s3 mb s3://my-bucket

$ aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket my-bucket \
    --output-template-file packaged-template.yaml
```

#### 2. Deploy to AWS Lambda & API Gateway with updated SAM template
```shell
$ aws cloudformation deploy \
    --template-file packaged-template.yaml \
    --stack-name go-serverless-api-stack \
    --capabilities CAPABILITY_IAM
```

#### 3. Test
AWS API Gateway addresses take the following format.
```
https://<api-rest-id>.execute-api.<your-aws-region>.amazonaws.com/<api-stage>
```

```Shell
$ aws apigateway get-rest-apis
{
    "items": [
        {
            "id": "0qu18x8pyd",
            "name": "go-serverless-api-stack",
            "createdDate": 1523987269,
            "version": "1.0",
            "apiKeySource": "HEADER",
            "endpointConfiguration": {
                "types": [
                    "EDGE"
                ]
            }
        }
    ]
}
```

```Shell
$ curl -s https://0qu18x8pyd.execute-api.eu-west-1.amazonaws.com/Stage/healthz
ok
$ curl -s https://0qu18x8pyd.execute-api.eu-west-1.amazonaws.com/Prod/healthz
ok
```

#### 4. Delete Stack
```shell
$ aws cloudformation delete-stack \
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
