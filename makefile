OWNER=rajatvig
IMAGE_NAME=pactbroker
QNAME=$(OWNER)/$(IMAGE_NAME)

GIT_TAG=$(QNAME):$(CIRCLE_SHA1)
BUILD_TAG=$(QNAME):0.1.0-b$(CIRCLE_BUILD_NUM)
LATEST_TAG=$(QNAME):latest

build:
	docker build -t $(GIT_TAG) .

lint:
	docker run -it --rm -v "$(PWD)/Dockerfile:/Dockerfile:ro" redcoolbeans/dockerlint

tag:
	docker tag $(GIT_TAG) $(BUILD_TAG)
	docker tag $(GIT_TAG) $(LATEST_TAG)

run:
	docker-compose up

login:
	@docker login -u "$(DOCKER_USER)" -p "$(DOCKER_PASS)"

push: login
	docker push $(GIT_TAG)
	docker push $(BUILD_TAG)
	docker push $(LATEST_TAG)
