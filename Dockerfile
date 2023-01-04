FROM circleci/golang:1.9.7

WORKDIR /usr/src/app

COPY go.mod go.sum main.go ./
COPY cmd ./cmd/
RUN go mod download && go mod verify
RUN go test -v ./cmd/
RUN go build -v -o /usr/local/bin/ ./...
