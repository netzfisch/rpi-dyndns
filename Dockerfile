# includes static quemu-library for automated builds at TravisCI
FROM hypriot/rpi-alpine:3.6
MAINTAINER netzfisch

# update base system
RUN apk add --update ca-certificates perl perl-net-ip wget \
  && rm -rf /var/cache/apk/*

# install ddclient-library
WORKDIR /usr/local/bin
RUN wget 'https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient' \
  && sed -i -e 's/Data::Validate/Net/' ddclient \
  && chmod +x ddclient

# configure ddclient-library
RUN mkdir /etc/ddclient /var/cache/ddclient
COPY ddclient.conf /etc/ddclient/
RUN  sed -i -e "s/@@login@@/$HOSTNAME/g" /etc/ddclient/ddclient.conf \
  && sed -i -e "s/@@password@@/$UPDATE_TOKEN/g" /etc/ddclient/ddclient.conf \
  && sed -i -e "s/@@hostname@@/$HOSTNAME/g" /etc/ddclient/ddclient.conf

ENTRYPOINT ["/usr/local/bin/ddclient"]
CMD ["-daemon=300", "-foreground", "-noquiet"]
