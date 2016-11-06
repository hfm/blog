FROM nginx
MAINTAINER OKUMURA Takahiro <hfm.garden@gmail.com>

RUN apt-get -qq update && apt-get -qq -y install curl jq rsync ruby-compass python3-pygments && apt-get -qq clean && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

RUN curl -sL $(curl -s https://api.github.com/repos/spf13/hugo/releases/latest | jq -r '.assets[] | select(.name | contains("Linux-64bit")) | .browser_download_url') | tar xz -C /usr/local/src --strip=1
RUN mv /usr/local/src/hugo* /usr/local/bin/hugo

COPY . /srv/blog
WORKDIR /srv/blog
RUN hugo
RUN gzip -k9 public/sitemap.xml
RUN rsync -a --delete public/ /usr/share/nginx/html
