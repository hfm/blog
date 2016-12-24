FROM alpine:3.4

RUN apk add --no-cache -q libstdc++ \
      && apk add --no-cache -q -t .build-deps git build-base cmake linux-headers zlib-dev \
      && git clone --depth 1 https://github.com/h2o/h2o \
      && cd h2o \
      && cmake . \
      && make install \
      && apk del -q .build-deps \
      && rm -rf /h2o

COPY h2o.conf /etc/h2o.conf
EXPOSE 80
CMD "h2o"