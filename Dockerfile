FROM alpine
# Certs are needed to talk to Let's Encrypt ACME resolver
RUN apk --no-cache add ca-certificates
COPY caddy /
ENV CADDYPATH /.cert
CMD ["/caddy", "-conf", "/Caddyfile", "-agree", "-email", "johnandersenpdx@gmail.com"]
