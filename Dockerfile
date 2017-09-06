FROM hypriot/rpi-alpine-scratch:v3.6
MAINTAINER netzfisch

# update 'perl' and install 'ddclient' libary
RUN apk add --update perl && \
    rm -rf /var/cache/apk/* && \
    cd /usr/sbin/ && \
    wget "https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient" && \
    chmod +x ddclient

Entrypoint ["/usr/sbin/ddclient"]
CMD ["-daemon=60", "-debug", "-verbose", "-noquiet", "-foreground"]

ONBUILD ADD ddclient.conf /etc/ddclient.conf
