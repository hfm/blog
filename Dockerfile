FROM alpine:3.6

RUN apk add --no-cache -q libstdc++
RUN apk add --no-cache -q -t .build-deps git build-base cmake linux-headers zlib-dev ruby ruby-rake ruby-dev bison
RUN git clone --depth 1 https://github.com/h2o/h2o
WORKDIR /h2o
RUN cmake -DWITH_MRUBY=ON -DWITH_BUNDLED_SSL=ON .
RUN make install
WORKDIR /
RUN apk del -q .build-deps && rm -rf /h2o

COPY h2o.conf /etc/h2o.conf
EXPOSE 80 443
CMD "h2o"
