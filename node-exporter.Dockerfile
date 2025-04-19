FROM golang:alpine as builder

WORKDIR /app

# Initialize a module
RUN go mod init node_exporter_build

# Install necessary packages
RUN apk update && apk add git && apk add ca-certificates

# Install node_exporter using go install instead of go get
RUN GOOS=linux GOARCH=arm GOARM=6 go install github.com/prometheus/node_exporter@latest

FROM scratch

# Copy the binary from the correct location
COPY --from=builder /go/bin/node_exporter /root/

EXPOSE 9100
ENTRYPOINT ["/root/node_exporter"]
