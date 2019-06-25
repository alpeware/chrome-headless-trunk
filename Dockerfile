FROM ubuntu:14.04

LABEL maintainer "Alpeware <info@alpeware.com>"

ENV REV=672025

EXPOSE 9222

RUN apt-get update -qqy \
  && apt-get -qqy install libnss3 libnss3-tools libfontconfig1 wget ca-certificates apt-transport-https inotify-tools unzip \
  libpangocairo-1.0-0 libx11-xcb-dev libxcomposite-dev libxcursor1 libxdamage1 libxi6 libgconf-2-4 libxtst6 libcups2-dev \
  libxss-dev libxrandr-dev libasound2-dev libatk1.0-dev libgtk-3-dev ttf-ancient-fonts chromium-codecs-ffmpeg-extra libappindicator3-1 \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
	&& dpkg -i dumb-init_*.deb \
	&& rm dumb-init_1.2.0_amd64.deb

RUN wget -q -O chrome.zip https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/$REV/chrome-linux.zip \
  && unzip chrome.zip \
  && rm chrome.zip \
  && ln -s $PWD/chrome-linux/chrome /usr/bin/google-chrome-unstable

RUN google-chrome-unstable --version

ADD start.sh import_cert.sh /usr/bin/

RUN mkdir /data
VOLUME /data
ENV HOME=/data DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/usr/bin/start.sh"]
