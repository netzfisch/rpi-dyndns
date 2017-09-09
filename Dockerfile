# includes static quemu-library for automated builds at TravisCI
FROM hypriot/rpi-alpine:3.6
MAINTAINER netzfisch

# update base system
RUN apk add --update ca-certificates perl perl-net-ip wget \
  && rm -rf /var/cache/apk/*

# install ddclient-library
RUN wget --directory-prefix=/usr/local/bin/ \
    'https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient' \
  && sed -i -e 's/Data::Validate/Net/' /usr/local/bin/ddclient

# configure ddclient-library
RUN mkdir /etc/ddclient /var/cache/ddclient
COPY ddclient.conf /etc/ddclient/
COPY setup /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/ddclient"]
CMD ["-daemon=300", "-foreground", "-noquiet"]
