FROM alpine:3.17

RUN apk add --no-cache bash
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
