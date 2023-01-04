FROM circleci/golang:1.9.7
# NOTE: Debian based image

ARG GO_VERSION=1.19.4
WORKDIR /go
USER circleci

# Update go version as circleci has a really old one
RUN curl -L https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz > go.tar.gz && \
    sudo rm -rf /usr/local/go && sudo tar -xzf go.tar.gz -C /usr/local && \
    sudo chown circleci:staff /usr/local/bin && \
    rm go.tar.gz

ENV GOROOT=/usr/local/go
ENV GOPATH=/home/circleci/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Setup and build the image tag updater binary
COPY go.mod go.sum main.go ./
COPY cmd ./cmd/
RUN go mod download && go mod verify
RUN go test -v ./cmd/
RUN go build -v -o /usr/local/bin/ ./...
# can run image-updater <commands>
# EX: /bin/bash -c image-updater ...
