FROM debian:9-slim

ENV H2O_VER 2.2.4
RUN apt-get -qq update \
      && apt-get -qq -y install --no-install-recommends build-essential cmake wget zlib1g-dev ca-certificates \
      && rm -rf /var/lib/apt/lists/* \
      && wget -q https://github.com/h2o/h2o/archive/v${H2O_VER}.tar.gz -O- | tar xz \
      && cd "h2o-${H2O_VER}" \
      && cmake -DWITH_BUNDLED_SSL=on . \
      && make \
      && make install \
      && rm -rf "/h2o-${H2O_VER}"

COPY h2o.conf /etc/h2o.conf
EXPOSE 80 443
CMD "h2o"
