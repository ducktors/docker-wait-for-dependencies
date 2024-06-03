FROM alpine:3.20

RUN apk add --no-cache bash
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
