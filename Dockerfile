# Build stage
FROM alpine:latest AS build

# Install build dependencies
RUN apk -U upgrade && apk add curl gzip jq

# Get mihomo
RUN wget $(\
  curl -s https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | \
  jq -r '.assets[] | select(.name | test("^mihomo-linux-amd64-v.*gz$")) | .browser_download_url'\
) && gzip -d *.gz && mv mihomo-* mihomo && chmod +x mihomo

# Bundle stage
FROM scratch:latest

# Copy mihomo
COPY --from=build /mihomo /mihomo

# Start up command
EXPOSE 9090
CMD ["/mihomo", "-d", "/data", "-f", "/data/config.yaml", "-ext-ctl", ":9090"]
