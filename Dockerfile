FROM golang:alpine as builder
RUN apk update && apk add git && apk add ca-certificates
RUN GOOS=linux GOARCH=arm GOARM=6 go get -u github.com/prometheus/node_exporter

FROM scratch
COPY --from=builder /go/bin/linux_arm/node_exporter /root/
EXPOSE 9100
ENTRYPOINT ["/root/node_exporter"]
