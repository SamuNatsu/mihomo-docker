FROM alpine:latest AS build

# Install build dependencies
RUN apk update && apk upgrade
RUN apk list --installed
