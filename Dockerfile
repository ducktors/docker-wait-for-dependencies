FROM alpine:3.17.3

RUN apk add --no-cache bash
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
