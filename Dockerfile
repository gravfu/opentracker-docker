
# Building the App (Multi-stage build)
FROM alpine:3 as builder

LABEL maintainer="vincent@gen-host.fr"

RUN apk add --no-cache git gcc make cvs musl-dev zlib-dev

WORKDIR /build

RUN cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat

WORKDIR /build/libowfat

RUN make

WORKDIR /build

RUN git clone git://erdgeist.org/opentracker

WORKDIR /build/opentracker

RUN make

# Copy exec in a new image to make the image smaller. (aprox. 5MB)

FROM alpine:3

LABEL maintainer="vincent@gen-host.fr"

WORKDIR /app

COPY --from=builder /build/opentracker/opentracker .

COPY ./opentracker.conf /etc/opentracker/opentracker.conf

COPY ./whitelist.txt /etc/opentracker/whitelist.txt

COPY ./blacklist.txt /etc/opentracker/blacklist.txt

EXPOSE 6969

CMD [ "/app/opentracker", "-f", "/etc/opentracker/opentracker.conf"]