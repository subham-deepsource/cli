build:
	cd cmd/deepsource && GOOS=linux GOARCH=amd64 go build -tags static_all -o /tmp/deepsource .

build_local:
	cd cmd/deepsource && GOOS=darwin GOARCH=amd64 go build -tags static_all -o /tmp/deepsource .

test:
	CGO_ENABLED=0 go test --cover -coverprofile=coverage.out -v ./command/report/tests/... -run TestReportKeyValueWorkflow
	CGO_ENABLED=0 go test --cover -coverprofile=coverage.out -v ./command/report/tests/... -run TestReportKeyValueFileWorkflow
	echo "\n====TESTING CONFIG VALIDATOR PACKAGE====\n"
	cd configvalidator && go test -v . -count=1

test_setup:
	mkdir -p ${CODE_PATH}
	cd ${CODE_PATH} && ls -A1 | xargs rm -rf
	git clone https://github.com/deepsourcelabs/cli ${CODE_PATH}
	chmod +x /tmp/deepsource
	cp ./command/report/tests/dummy/python_coverage.xml /tmp
