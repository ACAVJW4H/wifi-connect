FROM resin/raspberry-pi-debian:stretch AS build

RUN apt-get update \
    && apt-get install -y dnsmasq wireless-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN curl https://api.github.com/repos/ACAVJW4H/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*linux-rpi\.tar.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/src/app/

COPY scripts/start.sh .

CMD ["bash", "start.sh"]
