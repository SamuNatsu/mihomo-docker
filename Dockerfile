FROM alpine:latest AS build

# Install build dependencies
RUN apk -U upgrade && apk add curl gzip jq
RUN apk list --installed

# Get mihomo
RUN wget $(\
  curl -s https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | \
  jq -r '.assets[] | select(.name | test("^mihomo-linux-amd64-v.*gz$")) | .browser_download_url'\
) && gzip -d *.gz && mv mihomo-* mihomo
RUN ls -la
